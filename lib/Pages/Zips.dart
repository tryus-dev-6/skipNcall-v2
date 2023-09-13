import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Pages/PurchaseZip.dart';

class Zip extends StatefulWidget {
  const Zip({super.key});

  @override
  State<Zip> createState() => _ZipState();
}

class _ZipState extends State<Zip> {
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
                child: SingleChildScrollView(
                  child: Column(
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
                                      Icons.delete,
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
}
