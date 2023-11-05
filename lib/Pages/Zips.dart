import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:intl/intl.dart';
import 'package:skip_n_call/Pages/PurchaseZip.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skip_n_call/Pages/ZipDetails.dart';
import 'dart:developer' as developer;
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CartListData.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';
import 'Login.dart';

class Zip extends StatefulWidget {
  const Zip({super.key});

  @override
  State<Zip> createState() => _ZipState();
}

class _ZipState extends State<Zip> {

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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0XffFDF9FF),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 15, right: 15, bottom: 15),
                child: TextField(
                  cursorColor: const Color(0Xff634099),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          width: 1.5, color: Color(0Xff634099)),
                    ),
                    hintText: 'Find Your Zip',
                    prefixIcon: const Icon(Icons.search,
                        size: 30.0, color: Color(0Xff634099)),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        size: 30.0,
                        color: Color(0Xff634099),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SwipeRefresh.material(
                    scrollController: _scrollController,
                    stateStream: _stream,
                    onRefresh: refresh,
                    children : [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
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
                                    ? Container(
                                      padding: const EdgeInsets.only(bottom: 70),
                                      child: ListView.builder(
                                        itemCount: data.length + 1,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (context, index) {
                                          if (index < data.length) {
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ZipDetails(data: data[index]),
                                                  ),
                                                );
                                              },
                                                child: getSingleItem(data[index])
                                            );
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
                                      }),
                                    )
                                    : SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.70,
                                      child: const Center(
                                        child: Text(
                                          "No data Found"
                                      ),
                                    )
                                ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PurchaseZip(),
            ),
          );

        },
        backgroundColor: const Color(0xfffff4f1),
        icon: const Icon(Icons.add, color: Color(0Xff452b2e)),
        label: const Text("Purchase Zip", style: TextStyle(color: Color(0Xff452b2e))),

      ),
    );
  }


  Card getSingleItem(Datum data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0
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
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        'assets/images/ic_zip.svg',
                        color: const Color(0Xff634099),
                      ),
                    ),
                    Text(
                      data.zipCode.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color(0Xff00A18A)),
                    ),
                  ],
                ),
                GestureDetector(

                  onTap: (){
                    showCustomDialog(context, data);
                  },

                  child: Container(
                    width: 25,
                    height: 25,
                    child: const Icon(
                      Icons.delete,
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
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.my_location,
                      size: 22,
                      color: Color(0Xff634099),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${data.country}, ${data.city}, ${data.placeName}",
                      style: const TextStyle(
                          fontSize: 15,
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
                    width: 22,
                    height: 22,
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(
                      Icons.alarm,
                      size: 22,
                      color: Color(0Xff634099),
                    ),
                  ),
                  Text(
                    parseDate(data.createdAt.toString()),
                    style: const TextStyle(
                        fontSize: 15,
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
      "client_id": userId,
      "page": "1"
    };

    response = await BaseClient()
        .postWithToken('client/zip/list', cartBody)
        .catchError((err) {
      debugPrint('error: $err');
    });

    setState(() {
      isShimmerLoading = false;
    });

    if (response == null) {
      showSnackBar('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<Datum>? listData = allDatum.zipList?.data;
      setState(() {
        // totalAmount = allDatum.currentBalance!;
        //
        // developer.log(totalAmount, name: 'Total amount');

        if (allDatum.zipList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.zipList?.nextPageUrl);
          page = int.tryParse(nextPageUri.queryParameters['page'] ?? '')!;
        }

        isPaginateLoading = false;
        if (data.isNotEmpty) {
          data.clear();
        }
        data.addAll(listData!);
      });
    }
    else {
      if (allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
      if(allDatum.isTokenValid == false){
        toLogInPage();
      }
    }

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  void toLogInPage() {

    SharedPreferencesHelper.removeData(
        SKIP_N_CALL_USER_USERID);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ), (Route route) => false);
  }

  String parseDate(String? inputDate) {
    DateTime dateTime = DateTime.parse(inputDate!).toLocal();

    var outputFormat = DateFormat("d MMMM y 'at' h:mm a");

    return outputFormat.format(dateTime);
  }

  Future<void> loadMoreData() async {
    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    debugPrint("Page $page");

    var transaction = {
      "client_id": userId,
      "page": page.toString(),
    };

    var response;

    response = await BaseClient()
        .postWithToken('client/zip/list', transaction)
        .catchError((err) {});

    if (response == null) {
      showSnackBar('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<Datum>? listData = allDatum.zipList?.data;
      setState(() {
        isPaginateLoading = false;
        previousPage = page;

        if (allDatum.zipList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.zipList?.nextPageUrl);
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

  Future<void> releaseZip(Datum data) async {

    DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var delete = {
      "client_id": userId,
      "code": data.zipCode.toString(),
      "package_id": data.packageId,
    };

    response = await BaseClient()
        .postWithToken('client/zip/delete', delete)
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

  void showCustomDialog(BuildContext context, Datum data) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      // barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: const Text(
                  "Are you sure you want to release this zip ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                )),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),

                        ),
                        onPressed: (){
                          Navigator.of(context).pop();
                          releaseZip(data);
                        }, child: const Text(
                      'Ok',
                      style: TextStyle(fontSize: 16),
                    ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),

                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                          ),
                        ),

                      ),
                      onPressed: (){

                        Navigator.of(context).pop();

                      }, child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
