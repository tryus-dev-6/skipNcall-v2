
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/CustomDialogues/AddFundDialog.dart';
import 'package:skip_n_call/Model/TransactionData.dart';

import '../Api/base_client.dart';

class BalanceAndBilling extends StatefulWidget {
  const BalanceAndBilling({super.key});

  @override
  State<BalanceAndBilling> createState() => _BalanceAndBillingState();
}

class _BalanceAndBillingState extends State<BalanceAndBilling> {

  Map<String, dynamic>? paymentIntent;

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
                child: SingleChildScrollView(
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
                                    fontSize: 20, color: Color(0Xff634099)
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3.0),
                                child: const Text(
                                  "Your credits will automatically be replenished with the below amount when your balance reaches \$0.",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0Xff5A5A5A)
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 6.0),
                                child: const Text(
                                  "\$50",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 34,
                                      color: Color(0Xff434141)
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: 10,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index){
                            return getSingleItem();
                          }
                      ),


                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          showDialog(context: context,
              builder: (BuildContext context){
                return const AddFundDialog(
                  title: "Add Fund (min: \$50)",
                  descriptions: "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  text: "Ok",
                );
              }
          );

        },
        backgroundColor: const Color(0xfffff4f1),
        icon: const Icon(Icons.add, color: Color(0Xff452b2e)),
        label:
            const Text("Add Fund", style: TextStyle(color: Color(0Xff452b2e))),
      ),
    );
  }

  Card getSingleItem(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.only(
          top: 20.0, left: 20.0, right: 20.0),
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
                const Text(
                  "tr_2021111208595451536",
                  style: TextStyle(
                      fontSize: 16, color: Color(0Xff00A18A)),
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
                  const Text(
                    "10",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0Xff5A5A5A)),
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
                  const Text(
                    "11-12-2021 | 02:36:29 pm",
                    style: TextStyle(
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

  Future<void> loadData()async {
    var response;

    var transaction = {
      // "client_id": TFS,
      // "status": status,
      // "page": page.toString()
    };

    response = await BaseClient()
        .post('client/balance/transaction/list', transaction)
        .catchError((err) {});
  }



}
