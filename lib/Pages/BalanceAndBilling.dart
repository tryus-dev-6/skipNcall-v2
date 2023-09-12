import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:intl/intl.dart';
import 'package:skip_n_call/CustomDialogues/AddFundDialog.dart';
import 'package:skip_n_call/Model/CommonResponse.dart';
import 'package:skip_n_call/Model/TransactionData.dart';

import '../Api/Constants.dart';
import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Util/Constants.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import '../Util/Tools.dart';

class BalanceAndBilling extends StatefulWidget {
  const BalanceAndBilling({super.key});

  @override
  State<BalanceAndBilling> createState() => _BalanceAndBillingState();
}

class _BalanceAndBillingState extends State<BalanceAndBilling> {
  List<Data> data = [];
  bool isShimmerLoading = true;
  late bool isPaginateLoading = false;
  Map<String, dynamic>? paymentIntent;
  int page = 1;
  int previousPage = 1;
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  final ScrollController _scrollController = ScrollController();

  Stream<SwipeRefreshState> get _stream => _controller.stream;
  late String totalAmount = '';

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
                    hintText: 'Search',
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
                child: SwipeRefresh.material(
                  scrollController: _scrollController,
                  stateStream: _stream,
                  onRefresh: refresh,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: const EdgeInsets.only(
                                top: 20.0, left: 15.0, right: 15.0),
                            elevation: 5,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Balance',
                                    style: TextStyle(
                                        fontSize: 20, color: Color(0Xff634099)),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 3.0),
                                    child: const Text(
                                      "Your credits will automatically be replenished with the below amount when your balance reaches \$0.",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0Xff5A5A5A)),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      "\$$totalAmount",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 34,
                                          color: Color(0Xff434141)),
                                      textAlign: TextAlign.center,
                                    ),
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
                                      : const Card()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddFundDialog(
                  title: "Add Fund (min: \$50)",
                  descriptions:
                      "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  text: "Ok",
                  onClick: (String amount) {
                    paymentGateway(amount);
                  },
                );
              });
        },
        backgroundColor: const Color(0xfffff4f1),
        icon: const Icon(Icons.add, color: Color(0Xff452b2e)),
        label:
            const Text("Add Fund", style: TextStyle(color: Color(0Xff452b2e))),
      ),
    );
  }

  Card getSingleItem(Data data) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  margin: const EdgeInsets.only(right: 5),
                  child: SvgPicture.asset(
                    'assets/images/ic_transaction_id.svg',
                    color: const Color(0Xff634099),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${data.transactionId}",
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0Xff00A18A)),
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
                      Icons.monetization_on_outlined,
                      size: 22,
                      color: Color(0Xff634099),
                    ),
                  ),
                  Text(
                    "${data.paidAmount}",
                    style:
                        const TextStyle(fontSize: 15, color: Color(0Xff5A5A5A)),
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
                    parseDate(data.createdAt),
                    style:
                        const TextStyle(fontSize: 15, color: Color(0Xff5A5A5A)),
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

    var transaction = {
      "client_id": userId,
      "page": '1',
    };

    response = await BaseClient()
        .postWithToken('client/balance/transaction/list', transaction)
        .catchError((err) {
      debugPrint('error: $err');
    });

    isShimmerLoading = false;

    if (response == null) {
      debugPrint('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<Data>? listData = allDatum.transactionList?.data;
      setState(() {
        totalAmount = allDatum.currentBalance!;

        developer.log(totalAmount, name: 'Total amount');

        if (allDatum.transactionList?.nextPageUrl != null) {
          Uri nextPageUri = Uri.parse(allDatum.transactionList?.nextPageUrl);
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
        .postWithToken('client/balance/transaction/list', transaction)
        .catchError((err) {});

    if (response == null) {
      debugPrint('failed');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);
    if (allDatum.status == true) {
      List<Data>? listData = allDatum.transactionList?.data;
      setState(() {
        isPaginateLoading = false;
        totalAmount = allDatum.currentBalance!;
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

  String parseDate(String? inputDate) {
    DateTime dateTime = DateTime.parse(inputDate!).toLocal();

    var outputFormat = DateFormat("d MMMM y 'at' h:mm a");

    return outputFormat.format(dateTime);
  }

  Future<void> paymentGateway(String amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': "${amount}00",
        'currency': "USD",
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer ${Constants.STRIPE_SECRET_KEY}',
            'Content-type': 'application/x-www-form-urlencoded',
          },
          body: body);

      paymentIntent = json.decode(response.body);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: 'skipNcall',
          ))
          .then((value) => {});

      await Stripe.instance.presentPaymentSheet().then((value) => {
            saveSuccess(amount),
          });
    } catch (error) {
      throw Exception(error);
    }
  }

  void saveSuccess(String amount) async {
    var paymentIntentId = paymentIntent!['id'];
    developer.log('stripe', name: 'success');
    developer.log(paymentIntentId, name: 'success');

    addBalanceItem(paymentIntentId, amount);
  }

  Future<void> addBalanceItem(String paymentIntentId, String amount) async {
    var response;
    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var addTransaction = {
      "client_id": userId,
      "payment_id": paymentIntentId,
      "balance": amount,
    };

    response = await BaseClient()
        .postWithToken('client/add/balance', addTransaction)
        .catchError((err) {
      debugPrint('error: $err');
    });

    isShimmerLoading = false;

    if (response == null) {
      debugPrint('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      setState(() {
        loadData();
        showSnackBar("Successfully balance added");
        Timer(
            const Duration(seconds: 1),
            () => _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn)
        );
      });
    }

    paymentIntent = null;
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
