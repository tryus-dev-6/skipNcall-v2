
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ZipCart extends StatefulWidget {
  const ZipCart({super.key});

  @override
  State<ZipCart> createState() => _ZipCartState();
}

class _ZipCartState extends State<ZipCart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                      child: const SizedBox(
                        height: 17,
                        width: 17,
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
            ],

          ),
          body: ListView(
            children: [
              Card(
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
                              const Text(
                                "65478",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0Xff00A18A)),
                              ),
                            ],
                          ),
                          Container(
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
                            const Expanded(
                              child: Text(
                                "United States,	Missouri, Lawson",
                                style: TextStyle(
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
                                Icons.monetization_on_outlined,
                                size: 22,
                                color: Color(0Xff634099),
                              ),
                            ),
                            const Text(
                              "500",
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
              )
            ],
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const PurchaseZip(),
              //   ),
              // );

            },
            backgroundColor: const Color(0xfffff4f1),
            icon: SvgPicture.asset(
              height: 35,
              width: 35,
              'assets/images/ic_cart.svg',
              color: const Color(0Xff634099),
            ),
            label: const Text("Checkout", style: TextStyle(color: Color(0Xff452b2e))),

          ),
        ),
    );
  }
}
