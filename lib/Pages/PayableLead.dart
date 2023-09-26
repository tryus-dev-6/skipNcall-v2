
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skip_n_call/Util/Tools.dart';


class PayableLead extends StatefulWidget {
  const PayableLead({super.key});

  @override
  State<PayableLead> createState() => _PayableLeadState();
}

class _PayableLeadState extends State<PayableLead> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: const Color(0XffFDF9FF),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.center,
                      child: const Text(
                        "Payable lead",
                        style: TextStyle( color: Color(0Xff634099), fontSize: 20),
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                              elevation: 5,
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Warm Lead",
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          fontSize: 20, color: Color(0Xff00A18A)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: const Text(
                                        "Unpaid Lead - 10",
                                        style: TextStyle(
                                            fontSize: 15, color: Color(0Xff5A5A5A)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: const Text(
                                        "Payable - \$500",
                                        style: TextStyle(
                                            fontSize: 15, color: Color(0Xff5A5A5A)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                              elevation: 5,
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Home Owner Verified",
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          fontSize: 20, color: Color(0Xff00A18A)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: const Text(
                                        "Unpaid Lead - 10",
                                        style: TextStyle(
                                            fontSize: 15, color: Color(0Xff5A5A5A)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: const Text(
                                        "Payable - \$500",
                                        style: TextStyle(
                                            fontSize: 15, color: Color(0Xff5A5A5A)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                elevation: 5,
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Raw Lead",
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 20, color: Color(0Xff00A18A)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Unpaid Lead - 10",
                                          style: TextStyle(
                                              fontSize: 15, color: Color(0Xff5A5A5A)),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: const Text(
                                          "Payable - \$500",
                                          style: TextStyle(
                                              fontSize: 15, color: Color(0Xff5A5A5A)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Positioned(
                  bottom: 0, // Align to the bottom
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    height: 60,
                    child: ElevatedButton(

                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                            ),
                          ),

                        ),

                        onPressed: (){

                        }, child: const Text(
                        'Total payable - \$1500\n Pay Now',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    )
                    ),
                  )
                )

              ],
            ),
          )
      ),
    );
  }
}
