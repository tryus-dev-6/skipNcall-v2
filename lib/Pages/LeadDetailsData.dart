
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Model/Contact.dart';
import 'package:skip_n_call/Model/Questonaire.dart';
import 'package:skip_n_call/Model/leadList.dart';

class LeadDetailsData extends StatefulWidget {

  LeadList data;
  String leadType;

  LeadDetailsData({super.key, required this.data, required this.leadType});

  @override
  State<LeadDetailsData> createState() => _LeadDetailsDataState();
}

class _LeadDetailsDataState extends State<LeadDetailsData> {


  late LeadList data;

  @override
  void initState() {
    super.initState();

    data = widget.data;

  }

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
                      Flexible(
                        child: Text(
                          "${widget.data.firstName} ${widget.data.lastName}",
                          style: const TextStyle(
                              fontSize: 15, color: Color(0Xff5A5A5A)),
                        ),
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
                      Text(
                        widget.data.emailAddress.toString(),
                        style: const TextStyle(
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
                      Text(
                        widget.data.phoneNumber.toString(),
                        style: const TextStyle(
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
                      Flexible(
                        child: Text(
                          widget.data.propertyAddress.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Color(0Xff5A5A5A)),
                        ),
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
                      Text(
                        widget.data.zipCode.toString(),
                        style: const TextStyle(
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
                      Flexible(
                        child: Text(
                          widget.data.mailingAddress.toString(),
                          style: const TextStyle(
                              fontSize: 15, color: Color(0Xff5A5A5A)),
                        ),
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

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: data.contactEmail!.isNotEmpty
                            ? Container(
                              padding: const EdgeInsets.only(bottom: 10),
                                child: ListView.builder(
                              itemCount: data.contactEmail!.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                if (index < data.contactEmail!.length) {
                                  return getEmailSingleItem(data.contactEmail![index]);
                                }
                              }),
                        )
                            : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
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

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: data.contactPhone!.isNotEmpty
                            ? Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  itemCount: data.contactPhone!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    if (index < data.contactPhone!.length) {
                                      return getEmailSingleItem(data.contactPhone![index]);
                                    }
                                  }),
                        )
                            : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
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

                widget.leadType == "Warm lead" ? Row(
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
                ) : const Card(),

                widget.leadType == "Warm lead" ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20, left: 30, right: 20),
                        child: Text(
                          data.question.toString(),
                          style: const TextStyle(fontSize: 17, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
                        )),
                    const SizedBox(height: 24),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          data.answer.toString(),
                          style: const TextStyle(fontSize: 15, color: Color(0Xff5A5A5A))
                        ),
                      ),
                    ),
                  ],
                ) : const Card(),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: data.questonaire!.isNotEmpty
                            ? Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  itemCount: data.questonaire!.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    if (index < data.questonaire!.length) {
                                      return getQuestionnairesSingleItem(data.questonaire![index]);
                                    }
                                  }),
                        )
                            : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.10,
                              child: const Card(),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ));
  }

  Container getEmailSingleItem(Contact contactEmail){
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 30),
      child: Text(
        contactEmail.contact.toString(),
        style: const TextStyle(
            fontSize: 15, color: Color(0Xff5A5A5A)),
      ),
    );
  }

  Column getQuestionnairesSingleItem(Questonaire questionnaires){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 40, left: 30, right: 20),
            child: Text(
              questionnaires.question.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.black87, decoration: TextDecoration.none, fontFamily: 'system', fontWeight: FontWeight.normal),
            )
        ),
        const SizedBox(height: 24),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 20, bottom: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
                questionnaires.answer.toString(),
                style: const TextStyle(fontSize: 15, color: Color(0Xff5A5A5A))
            ),
          ),
        ),
      ],
    );
  }

}
