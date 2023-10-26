
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Model/leadList.dart';

class LeadDetailsData extends StatefulWidget {

  LeadList data;

  LeadDetailsData({super.key, required this.data});

  @override
  State<LeadDetailsData> createState() => _LeadDetailsDataState();
}

class _LeadDetailsDataState extends State<LeadDetailsData> {
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
            title: const Text("Lead Details",
                style: TextStyle(
                  color: Color(0Xff634099),
                )),
            backgroundColor: const Color(0XffFDF9FF),

          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0XffFDF9FF),
            ),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 15),
                  child: const Text(
                    'Basic Information',
                    style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15, left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.account_circle_rounded,
                          size: 22,
                          color: Color(0Xff634099),
                        ),
                      ),
                      const Text(
                        "Abdulla Al Mued",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.email,
                          size: 22,
                          color: Color(0Xff634099),
                        ),
                      ),
                      const Text(
                        "mued@gmail.com",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.phone,
                          size: 22,
                          color: Color(0Xff634099),
                        ),
                      ),
                      const Text(
                        "01832587160",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15),
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
                      const Text(
                        "address",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15),
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
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.place_outlined,
                          size: 22,
                          color: Color(0Xff634099),
                        ),
                      ),
                      const Text(
                        "Mailing address",
                        style: TextStyle(
                            fontSize: 15, color: Color(0Xff5A5A5A)),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 15),
                      child: const Text(
                        'Other Mail Address',
                        style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(left: 5, top: 20),
                      child: const Icon(
                        Icons.email,
                        size: 22,
                        color: Color(0Xff634099),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15, left: 30),
                  child: const Text(
                    "mued@gmail.com",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30),
                  child: const Text(
                    "mued@gmail.com",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30),
                  child: const Text(
                    "mued@gmail.com",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 15),
                      child: const Text(
                        'Other Phone Numbers',
                        style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(left: 5, top: 20),
                      child: const Icon(
                        Icons.phone,
                        size: 22,
                        color: Color(0Xff634099),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15, left: 30),
                  child: const Text(
                    "01236445789",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30),
                  child: const Text(
                    "01236445789",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30),
                  child: const Text(
                    "01236445789",
                    style: TextStyle(
                        fontSize: 15, color: Color(0Xff5A5A5A)),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 15),
                      child: const Text(
                        'Questionnaires',
                        style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(left: 5, top: 23),
                      child: const Icon(
                        Icons.question_answer_sharp,
                        size: 22,
                        color: Color(0Xff634099),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: const Text(
                          "Question ?",
                          style: TextStyle(fontSize: 16, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(height: 24),
                    Container(
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
                  ],
                ),

              ],
            ),
          ),
        ));
  }
}
