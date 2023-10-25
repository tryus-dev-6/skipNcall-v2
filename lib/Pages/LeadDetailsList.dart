import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skip_n_call/Model/Leads.dart';
import 'package:skip_n_call/Model/leadList.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'dart:developer' as developer;
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';
import '../Util/Tools.dart';

class LeadDetailsList extends StatefulWidget {

  final String leadType, zipCode, lt;

  const LeadDetailsList({super.key, required this.leadType, required this.zipCode, required this.lt});

  @override
  State<LeadDetailsList> createState() => _LeadDetailsListState();
}

class _LeadDetailsListState extends State<LeadDetailsList> {

  List<LeadList> data = [];
  bool isShimmerLoading = true;
  late bool isPaginateLoading = false;
  int page = 1;
  int previousPage = 1;
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  final ScrollController _scrollController = ScrollController();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  String leadType = "", zip = "", leadType2 = "";


  @override
  void initState() {
    super.initState();

    leadType = widget.leadType.toString();
    zip = widget.zipCode.toString();
    leadType2 = widget.lt.toString();

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
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Color(0Xff634099), // <-- SEE HERE
        ),
        centerTitle: true,
        title: const Text("Leads",
            style: TextStyle(
              color: Color(0Xff634099),
            )),
        backgroundColor: const Color(0XffFDF9FF),
      ),
      body: SafeArea(
          child: Container(
            color: const Color(0XffFDF9FF),
            child: Column(
              children: [
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
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) => ZipDetails(data: data[index]),
                                                //   ),
                                                // );
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
          )),
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

  Card getSingleItem(LeadList data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        'assets/images/ic_user.svg',
                        color: const Color(0Xff634099),
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        "Abdula Al Mued",
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontSize: 16, color: Color(0Xff00A18A)),
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
                        child: SvgPicture.asset(
                          'assets/images/ic_zip.svg',
                          color: const Color(0Xff634099),
                        ),
                      ),
                      const Text(
                        "10001",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //   bottom: 0, // Align to the bottom
            //   right: 0,
            //   child: ElevatedButton(
            //
            //       style: ElevatedButton.styleFrom(
            //           elevation: 12.0,
            //           backgroundColor: const Color(0Xff634099),
            //           textStyle: const TextStyle(color: Colors.white)),
            //
            //       onPressed: () {
            //         showCustomDialog(context);
            //       },
            //       child: const Text("Questionnaires")),
            // )
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    page = 1;
    previousPage = 1;

    var response;

    var cartBody = {
      "zip_code": zip,
      "lead_type": leadType2,
      "page": "1"
    };

    response = await BaseClient()
        .postWithToken('client/lead/details', cartBody)
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
      List<LeadList>? listData = allDatum.leads?.data;
      setState(() {
        // totalAmount = allDatum.currentBalance!;
        //
        // developer.log(totalAmount, name: 'Total amount');

        if (allDatum.leads?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.leads?.nextPageUrl);
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

    debugPrint("Page $page");

    var transaction = {
      "zip_code": zip,
      "lead_type": leadType2,
      "page": page.toString(),
    };

    var response;

    response = await BaseClient()
        .postWithToken('client/lead/details', transaction)
        .catchError((err) {});

    if (response == null) {
      showSnackBar('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<LeadList>? listData = allDatum.leads?.data;
      setState(() {
        isPaginateLoading = false;
        previousPage = page;

        if (allDatum.leads?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.leads?.nextPageUrl);
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

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      // barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 450,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: const Text(
                      "Question ?",
                      style: TextStyle(fontSize: 16, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                    )),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                          "Please set to minLines 1 and maxLines to 8. If Message is short it's will take one line if there is large text it's will be auto scroll. You can change max line according to your needs. Here's an example for reference. "
                              "Please set to minLines 1 and maxLines to 8. If Message is short it's will take one line if there is large text it's will be auto scroll. You can change max line according to your needs. Here's an example for reference."
                              "Please set to minLines 1 and maxLines to 8. If Message is short it's will take one line if there is large text it's will be auto scroll. You can change max line according to your needs. Here's an example for reference."
                              "Please set to minLines 1 and maxLines to 8. If Message is short it's will take one line if there is large text it's will be auto scroll. You can change max line according to your needs. Here's an example for reference.",
                        style: TextStyle(fontSize: 16, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
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

}
