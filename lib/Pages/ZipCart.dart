
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Pages/Navigation.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CartListData.dart';
import 'dart:developer' as developer;
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Model/CommonResponse.dart';
import '../Util/ColorCodes.dart';
import '../Util/Constants.dart';
import 'package:shimmer/shimmer.dart';

import '../Util/Tools.dart';

class ZipCart extends StatefulWidget {
  const ZipCart({super.key});

  @override
  State<ZipCart> createState() => _ZipCartState();
}

class _ZipCartState extends State<ZipCart> {

  List<Datum> data = [];
  bool isShimmerLoading = true;
  late bool isPaginateLoading = false;
  int page = 1;
  int previousPage = 1;
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  final ScrollController _scrollController = ScrollController();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  late String totalAmount = '';
  String cartCount = '';

  @override
  void initState() {
    super.initState();

    loadData();

    _scrollController.addListener(() {
      developer.log('${_scrollController.position.pixels}', name: 'OnScroll');

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        debugPrint("Scrolled Page : $page Previous Page :$previousPage");
        if (page != previousPage && !isPaginateLoading) {
          setState(() {
            isPaginateLoading = true;
          });
          loadMoreData();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.close();
    super.dispose();
  }

  Future<void> refresh() async {
    setState(() {
      page = 1;
      previousPage = 1;
      developer.log('yes', name: 'refreshed');
      loadData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0XffFDF9FF),
          appBar: AppBar(
            elevation: 0,
            leading: const BackButton(
              color: Color(0Xff634099), // <-- SEE HERE
            ),
            centerTitle: true,
            title: const Text("Selected Items",
                style: TextStyle(
                  color: Color(0Xff634099),
                )),
            backgroundColor: const Color(0XffFDF9FF),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: color0,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: color0),

            actions: <Widget>[
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 40, top: 10),
                    child: SvgPicture.asset(
                      height: 35,
                      width: 35,
                      'assets/images/ic_cart.svg',
                      color: const Color(0Xff634099),
                    ),
                  ),
                  Card(
                      margin: const EdgeInsets.only(right: 40, top: 10),
                      color: const Color(0Xff00A18A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      child: SizedBox(
                        height: 17,
                        width: 17,
                        child: Center(
                          child: Text(
                            cartCount,
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
            ],

          ),
          body: SwipeRefresh.material(
              scrollController: _scrollController,
              stateStream: _stream,
              onRefresh: refresh,
            children : [
              Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 15.0, right: 15.0),
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Summary',
                            style: TextStyle(
                                fontSize: 18, color: Color(0Xff634099)),
                          ),

                          Container(
                            margin: const EdgeInsets.only(top: 6, bottom: 5),
                            height: 1,
                            color: Colors.grey,
                          ),

                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Zip',
                                    style: TextStyle(fontSize: 14, color: Color(0Xff434141)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: const Text(
                                      'Total Amount',
                                      style: TextStyle(fontSize: 14, color: Color(0Xff434141)),
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        ':',
                                        style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: const Text(
                                          ':',
                                          style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartCount,
                                    style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "\$$totalAmount",
                                      style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: isShimmerLoading
                          ? ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: 10,
                          itemBuilder:
                              (BuildContext context, int index) {
                            return getShimmerLoading();
                          })
                          : data.isNotEmpty
                          ? ListView.builder(
                          itemCount: data.length + 1,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            if (index < data.length) {
                              return getSingleItem(data[index]);
                            } else if (isPaginateLoading) {
                              return Container(
                                margin:
                                const EdgeInsets.all(10),
                                height: 40,
                                alignment: Alignment.center,
                                child: LoadingAnimationWidget
                                    .staggeredDotsWave(
                                  color: Colors.black87,
                                  size: 40,
                                ),
                              );
                            }
                          })
                          : ListView.builder(
                            itemCount:1,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.center,
                                height: 350,
                                child: const Text(
                                    "No data Found"
                                ),
                              );
                            },
                          )
                  ),
                ],
              ),
            ]
          ),

          floatingActionButton: data.isNotEmpty? FloatingActionButton.extended(
            onPressed: (){
              checkOut();
            },
            heroTag: UniqueKey(),
            backgroundColor: const Color(0xfffff4f1),
            icon: SvgPicture.asset(
              height: 35,
              width: 35,
              'assets/images/ic_cart.svg',
              color: const Color(0Xff634099),
            ),
            label: const Text("Checkout", style: TextStyle(color: Color(0Xff452b2e))),

          ) : const Card(),
        ),
    );
  }


  Card getSingleItem(Datum data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(
          top: 10.0, left: 20.0, right: 20.0
      ),
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        'assets/images/ic_zip.svg',
                        color: const Color(0Xff634099),
                      ),
                    ),
                    Text(
                      "${data.zipCode}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0Xff00A18A)),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    deleteCartItem(data.zipCode!, data.packageId!);
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    padding: const EdgeInsets.only(
                        bottom: 5, right: 5, left: 5),
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.clear,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.my_location,
                      size: 18,
                      color: Color(0Xff634099),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "${data.country}, ${data.city}, ${data.placeName}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0Xff5A5A5A)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.monetization_on_outlined,
                      size: 18,
                      color: Color(0Xff634099),
                    ),
                  ),
                  const Text(
                    "500",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0Xff5A5A5A)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    page = 1;
    previousPage = 1;

    var response;
    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);



    var cartBody = {
      "client_id": userId
    };

    response = await BaseClient()
        .postWithToken('client/zip/cart/list', cartBody)
        .catchError((err) {
      debugPrint('error: $err');
    });

    isShimmerLoading = false;

    if (response == null) {
      showSnackBar('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<Datum>? listData = allDatum.cartList?.data;
      setState(() {
        // totalAmount = allDatum.currentBalance!;
        //
        // developer.log(totalAmount, name: 'Total amount');

        cartCount = allDatum.cartCount.toString();
        totalAmount = allDatum.totalCartPrice.toString();

        if (allDatum.cartList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.cartList?.nextPageUrl);
          page = int.tryParse(nextPageUri.queryParameters['page'] ?? '')!;
        }

        isPaginateLoading = false;
        if (data.isNotEmpty) {
          data.clear();
        }
        data.addAll(listData!);
      });
    }

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  Future<void> loadMoreData() async {
    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    debugPrint("Page $page");

    var transaction = {
      "client_id": userId,
      "page": page.toString(),
    };

    var response;

    response = await BaseClient()
        .postWithToken('client/zip/cart/list', transaction)
        .catchError((err) {});

    if (response == null) {
      showSnackBar('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<Datum>? listData = allDatum.cartList?.data;
      setState(() {
        isPaginateLoading = false;
        previousPage = page;

        if (allDatum.cartList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.cartList?.nextPageUrl);
          page = int.tryParse(nextPageUri.queryParameters['page'] ?? '')!;
          if (page != null) {
            print('Page number: $page');
          } else {
            print('Invalid page number');
          }
        }

        data.addAll(listData!);
      });
    }
  }

  Card getShimmerLoading() {
    return Card(
      // width: Tools.getSize(1, context),
      // height: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        elevation: 5,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[350]!,
          highlightColor: Colors.grey[100]!,
          period: const Duration(milliseconds: 1000),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.1, context),
                            height: 20,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.65, context),
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.1, context),
                            height: 20,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.45, context),
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.1, context),
                            height: 20,
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: SizedBox(
                            width: Tools.getSize(0.65, context),
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ));
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: const Color(0Xff1E1E1E),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.blue,
        onPressed: () {
          SnackbarController.closeCurrentSnackbar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteCartItem(int zipCode, String packageId) async {

    DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var add = {
      "client_id": userId,
      "code": zipCode.toString(),
      "package_id": packageId,
    };

    response = await BaseClient()
        .postWithToken('client/zip/cart/delete', add)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      showSnackBar('failed to get response');
      DialogHelper.hideDialog();

      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      if(allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }

      loadData();
    }
    else{
      if(allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
    }

    DialogHelper.hideDialog();

  }

  Future<void> checkOut() async {

    DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var checkOut = {
      "client_id": userId
    };

    response = await BaseClient()
        .postWithToken('client/zip/checkout', checkOut)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      showSnackBar('failed to get response');
      DialogHelper.hideDialog();
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      if(allDatum.message != null) {

        showSnackBar(allDatum.message.toString());

      }

      loadData();
      successCheckout();

    }
    else{
      if(allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
    }

    DialogHelper.hideDialog();

  }

  void successCheckout() {

    Get.toNamed("/home");

  }

}
