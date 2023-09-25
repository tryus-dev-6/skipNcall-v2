import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Util/Tools.dart';

class LeadDetailsList extends StatefulWidget {
  const LeadDetailsList({super.key});

  @override
  State<LeadDetailsList> createState() => _LeadDetailsListState();
}

class _LeadDetailsListState extends State<LeadDetailsList> {
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
                Card(
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
                                    child: const Icon(
                                      Icons.mail_outlined,
                                      size: 22,
                                      color: Color(0Xff634099),
                                    ),
                                  ),
                                  const Text(
                                    "tryus.dev6@gmail.com",
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0Xff5A5A5A)),
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
                                      Icons.phone,
                                      size: 22,
                                      color: Color(0Xff634099),
                                    ),
                                  ),
                                  const Text(
                                    "01831553096",
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0Xff5A5A5A)),
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
                                      Icons.my_location,
                                      size: 22,
                                      color: Color(0Xff634099),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Tools.getSize(0.40, context),
                                    child: const Text(
                                      "Reno, NV, USA",

                                      style: TextStyle(
                                          fontSize: 15, color: Color(0Xff5A5A5A)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0, // Align to the bottom
                          right: 0,
                          child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                  elevation: 12.0,
                                  backgroundColor: const Color(0Xff634099),
                                  textStyle: const TextStyle(color: Colors.white)),

                              onPressed: () {
                                showCustomDialog(context);
                              },
                              child: const Text("Questionnaires")),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
      )),
    );
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
}
