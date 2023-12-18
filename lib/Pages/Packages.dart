import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Model/CommonResponse.dart';
import '../Model/PackageListData.dart';
import '../Util/ColorCodes.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Login.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> with AutomaticKeepAliveClientMixin<Packages>{
  List<Data> data = [];
  bool isShimmerLoading = true;
  late bool isPaginateLoading = false;
  int page = 1;
  int previousPage = 1;
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  final ScrollController _scrollController = ScrollController();
  String currentPackageId = '';
  Stream<SwipeRefreshState> get _stream => _controller.stream;
  BuildContext? mContext;

  @override
  Widget build(BuildContext context) {

    mContext = context;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Packages",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: color0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: color0,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: color0),
        ),
      body: SafeArea(
        child: Container(
          color: const Color(0XffFDF9FF),
          child: SwipeRefresh.material(
            scrollController: _scrollController,
            stateStream: _stream,
            onRefresh: refresh,
            children: [
              Container(
                child: isShimmerLoading
                    ? ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return getShimmerLoading();
                    })
                    : data.isNotEmpty ? Container(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: ListView.builder(
                      itemCount: data.length + 1,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        if (index < data.length) {
                          return getSingleItem(data[index]);
                        } else if (isPaginateLoading) {
                          return Container(
                            margin: const EdgeInsets.all(10),
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
                    height: MediaQuery.of(context).size.height * 0.85,
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
      ),
    );
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

  Card getShimmerLoading() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        elevation: 5,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[350]!,
            highlightColor: Colors.grey[100]!,
            period: const Duration(milliseconds: 1000),
            child: Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: SizedBox(
                          width: Tools.getSize(0.5, context),
                          height: 10,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        color: Colors.white,
                        child: SizedBox(
                          width: Tools.getSize(0.5, context),
                          height: 10,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        color: Colors.white,
                        child: SizedBox(
                          width: Tools.getSize(0.5, context),
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XffD9D9D9)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: Tools.getSize(0.3, context),
                                    height: 20,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 4, bottom: 4),
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: Tools.getSize(0.3, context),
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: Tools.getSize(0.3, context),
                                    height: 20,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 4, bottom: 4),
                                  color: Colors.white,
                                  child: SizedBox(
                                    width: Tools.getSize(0.3, context),
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          color: const Color(0XffD9D9D9),
                          height: 1,
                        ),
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 4, bottom: 4),
                          child: SizedBox(
                            width: Tools.getSize(0.5, context),
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XffD9D9D9)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            color: Colors.white,
                            child: SizedBox(
                              width: Tools.getSize(0.5, context),
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0XffD9D9D9),
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: Tools.getSize(0.3, context),
                                      height: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: Tools.getSize(0.3, context),
                                      height: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: Tools.getSize(0.3, context),
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: Tools.getSize(0.3, context),
                                      height: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Container(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: Tools.getSize(0.3, context),
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          color: const Color(0XffD9D9D9),
                          height: 1,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: Tools.getSize(0.2, context),
                                  height: 20,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: Tools.getSize(0.2, context),
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XffD9D9D9)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            color: Colors.white,
                            child: SizedBox(
                              width: Tools.getSize(0.5, context),
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: Tools.getSize(0.2, context),
                                  height: 20,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                child: SizedBox(
                                  width: Tools.getSize(0.2, context),
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(5.0), // Set border radius
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          elevation: 12.0,
                          backgroundColor: const Color(0Xff634099),
                          textStyle: const TextStyle(color: Colors.white)),
                      child: Container(
                        color: Colors.white,
                        child: SizedBox(
                          width: Tools.getSize(0.5, context),
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Card getSingleItem(Data data) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    '${data.packageName}',
                    style:
                        const TextStyle(fontSize: 20, color: Color(0Xff434141)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      '${data.minZip}-${data.maxZip} Zips',
                      style: const TextStyle(
                          fontSize: 18, color: Color(0Xff434141)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$${data.packagePrice}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                                color: Color(0Xff434141)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: const Text(
                              '/Month',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff434141)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XffD9D9D9)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text(
                        'Home Owner Verified',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0Xff634099)),
                      ),
                    ),
                    Container(
                      color: const Color(0XffD9D9D9),
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: const Text(
                                'Mailing Address',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Email Address',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: const Text(
                                'Verified Owner',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: const Color(0XffD9D9D9),
                      height: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$${data.hovLeadPrice}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0Xff434141)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              '/lead',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff434141)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XffD9D9D9)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: const Text(
                        'Warm Lead',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0Xff634099)),
                      ),
                    ),
                    Container(
                      color: const Color(0XffD9D9D9),
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Mailing Address',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: const Text(
                                'Full Questionnaires',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Email Address',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: const Text(
                                'Verified Owner',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0Xff434141)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: const Color(0XffD9D9D9),
                      height: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\$${data.warmLeadPrice}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0Xff434141)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              '/lead',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff434141)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XffD9D9D9)),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: const Text(
                        "Skip Tracing",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0Xff634099)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "\$5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0Xff434141)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              '/lead',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0Xff434141)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0), // Set border radius
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (data.packageId != null) {
                      purchasePackage(data.packageId);
                    } else {
                      Tools.flushBarErrorMessage("Package id not found", mContext!);
                    }
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      elevation: 12.0,
                      backgroundColor: currentPackageId == data.packageId
                          ? const Color(0Xff00A18A)
                          : const Color(0Xff634099),
                      textStyle: const TextStyle(color: Colors.white)),
                  child: currentPackageId == data.packageId
                      ? const Text('Selected')
                      : const Text('Select'),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> loadData() async {

    if (!mounted) {
      return;
    }

    page = 1;
    previousPage = 1;

    debugPrint('current package: $currentPackageId');

    var response;
    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var package = {
      "client_id": userId,
      "page": '1',
    };

    response = await BaseClient()
        .postWithToken('client/package/list', package)
        .catchError((err) {
      debugPrint('error: $err');
    });


    if (!mounted) {
      return;
    }

    setState(() {
      isShimmerLoading = false;
    });

    if (response == null) {
      debugPrint('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<Data>? listData = allDatum.packageResponse?.data;

      if (!mounted) {
        return;
      }

      setState(() {
        if (allDatum.transactionList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.transactionList?.nextPageUrl);
          page = int.tryParse(nextPageUri.queryParameters['page'] ?? '')!;
        }

        if (allDatum.purchasedPackage == null) {
          currentPackageId = '';
        } else {
          currentPackageId = allDatum.purchasedPackage.toString();
        }

        debugPrint('current package id: $currentPackageId');

        isPaginateLoading = false;
        if (data.isNotEmpty) {
          data.clear();
        }
        data.addAll(listData!);
      });
    } else {
      if (allDatum.message != null) {
        Tools.flushBarErrorMessage(allDatum.message.toString(), mContext!);
      }
      if(allDatum.isTokenValid == false){
        toLogInPage();
      }
    }

    _controller.sink.add(SwipeRefreshState.hidden);
  }

  Future<void> toLogInPage() async {

    String email = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_EMAIL);
    String password = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_PASSWORD);
    SharedPreferencesHelper.clearAllData();
    SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_EMAIL, email);
    SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_PASSWORD, password);
    Get.offAllNamed('/login');

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
        .postWithToken('client/package/list', transaction)
        .catchError((err) {});

    if (response == null) {
      debugPrint('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<Data>? listData = allDatum.packageResponse?.data;
      setState(() {
        isPaginateLoading = false;
        previousPage = page;

        if (allDatum.transactionList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.transactionList?.nextPageUrl);
          page = int.tryParse(nextPageUri.queryParameters['page'] ?? '')!;
          if (page != null) {
            print('Page number: $page');
          } else {
            print('Invalid page number');
          }
        }

        data.addAll(listData!);
      });
    } else {
      Tools.flushBarErrorMessage(allDatum.message!, mContext!);
    }
  }

  Future<void> purchasePackage(String? packageId) async {
    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var purchasePackageBody = {
      "client_id": userId,
      "payment_id": "122",
      "package_id": packageId,
    };

    var response;

    response = await BaseClient()
        .postWithToken('client/select/package', purchasePackageBody)
        .catchError((err) {});

    if (response == null) {
      debugPrint('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      setState(() {
        currentPackageId = packageId!;
        SharedPreferencesHelper.saveData(
            SKIP_N_CALL_PURCHASED_PACKAGE, packageId);
      });
    }

    Tools.flushBarSuccessMessage(allDatum.message!, mContext!);
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color(0Xff1E1E1E),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.blue,
        onPressed: () {
          //SnackbarController.closeCurrentSnackbar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class MySVG extends AssetBundle {
  final String imagePath;

  MySVG({required this.imagePath});

  @override
  Future<ByteData> load(String key) async {
    // TODO: implement load
    return await rootBundle.load(imagePath);
  }

  @override
  Future<T> loadStructuredData<T>(
      String key, Future<T> Function(String value) parser) {
    // TODO: implement loadStructuredData
    throw UnimplementedError();
  }
}
