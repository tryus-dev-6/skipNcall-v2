import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'dart:async';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0XffFDF9FF),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.only(
                              top: 20.0, left: 20.0, right: 20.0
                          ),
                          elevation: 5,
                          child: Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Package Name',
                                      style: TextStyle(
                                          fontSize: 20, color: Color(0Xff434141)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3.0),
                                      child: const Text(
                                        '5-10 Zips',
                                        style: TextStyle(
                                            fontSize: 18, color: Color(0Xff434141)),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 6.0),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "\$50",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 34,
                                                  color: Color(0Xff434141)),
                                            ),
                                            Container(
                                              margin:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: const Text(
                                                '/Month',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0Xff434141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XffD9D9D9)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
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
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                child: const Text(
                                                  'Mailing Address',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)),
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
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                child: const Text(
                                                  'Verified Owner',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)),
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
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "\$10",
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
                                                    fontSize: 14,
                                                    color: Color(0Xff434141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XffD9D9D9)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
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
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(top: 5),
                                                child: const Text(
                                                  'Mailing Address',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                child: const Text(
                                                  'Full Questionnaires',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)),
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
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topCenter,
                                                margin: const EdgeInsets.only(top: 5, bottom: 5),
                                                child: const Text(
                                                  'Verified Owner',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0Xff434141)),
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
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "\$15",
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
                                                    fontSize: 14,
                                                    color: Color(0Xff434141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XffD9D9D9)),
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
                                        margin:
                                            const EdgeInsets.only(top: 5, bottom: 10),
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
                                                    fontSize: 14,
                                                    color: Color(0Xff434141)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(top: 10,bottom: 20),
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0), // Set border radius
                                ),
                                  child: ElevatedButton(

                                    onPressed: () {},
                                    // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 12.0,

                                        backgroundColor: const Color(0Xff634099),
                                        textStyle: const TextStyle(color: Colors.white)),
                                    child: const Text('Purchase'),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
