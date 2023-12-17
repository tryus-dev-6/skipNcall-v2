import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:intl/intl.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Model/CommonResponse.dart';
import '../Model/NotificationData.dart';
import '../Util/ColorCodes.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';
import 'Login.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  List<NotificationData> data = [];
  bool isShimmerLoading = true;
  late bool isPaginateLoading = false;
  int page = 1;
  int previousPage = 1;
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  final ScrollController _scrollController = ScrollController();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  BuildContext? mContext;

  @override
  void initState() {
    // TODO: implement initState
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
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.white,
    //   statusBarIconBrightness: Brightness.light,
    // ));

    mContext = context;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          centerTitle: true,
          title: const Text("Notification",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: color0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: color0,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: color0),
        ),
        body: Container(
          color: const Color(0XffFDF9FF),
          child: SwipeRefresh.material(
              scrollController: _scrollController,
              stateStream: _stream,
              onRefresh: refresh,
              children: [
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
                                      }),
                        )
                            : SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.90,
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
    );
  }

  Future<void> loadData() async {
    page = 1;
    previousPage = 1;

    var response;
    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);


    var cartBody = {
      "user_id": userId,
      "page": "1"
    };

    response = await BaseClient()
        .postWithToken('user/notifications', cartBody)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (mounted) {
      setState(() {
        isShimmerLoading = false;
      });
    }

    if (response == null) {
      Tools.flushBarErrorMessage('failed to get response', mContext!);
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<NotificationData>? listData = allDatum.notifications?.data;
      setState(() {
        // totalAmount = allDatum.currentBalance!;
        //
        // developer.log(totalAmount, name: 'Total amount');

        if (allDatum.notifications?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.notifications?.nextPageUrl);
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
        Tools.flushBarErrorMessage(allDatum.message.toString(), mContext!);
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

    Get.offAllNamed("/login");
  }

  Future<void> loadMoreData() async {
    String? userId = await SharedPreferencesHelper.getData(
        SKIP_N_CALL_USER_USERID);

    debugPrint("Page $page");

    var transaction = {
      "user_id": userId,
      "page": page.toString(),
    };

    var response;

    response = await BaseClient()
        .postWithToken('user/notifications', transaction)
        .catchError((err) {});

    if (response == null) {
      Tools.flushBarErrorMessage("failed", mContext!);
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<NotificationData>? listData = allDatum.notifications?.data;
      setState(() {
        isPaginateLoading = false;
        previousPage = page;

        if (allDatum.notifications?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.notifications?.nextPageUrl);
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

  Card getSingleItem(NotificationData data) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.only(
            top: 10.0, left: 10.0, right: 10.0),
        elevation: 5,
        color: const Color(0XffEFEFEF),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
              child: SvgPicture.asset(
                'assets/images/ic_notification2.svg',
                height: 45,
                width: 45,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                  child: Text(
                    data.data.toString(),
                    style: const TextStyle(
                        fontSize: 14, color: Color(0Xff434141)),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 5),
                  child: Text(
                    parseDate(data.createdAt.toString()),
                    style: const TextStyle(
                        fontSize: 14, color: Color(0Xff00A18A)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],

            ),
          ],
        )
    );
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

  String parseDate(String? inputDate) {
    DateTime dateTime = DateTime.parse(inputDate!).toLocal();

    var outputFormat = DateFormat("d MMMM y 'at' h:mm a");

    return outputFormat.format(dateTime);
  }

}
