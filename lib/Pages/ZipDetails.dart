
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Model/CartListData.dart';
import 'package:skip_n_call/Pages/LeadDetailsList.dart';

import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';

class ZipDetails extends StatefulWidget {

  final Datum data;
  const ZipDetails({super.key, required this.data});

  @override
  State<ZipDetails> createState() => _ZipDetailsState();
}

class _ZipDetailsState extends State<ZipDetails> {

  late String warmLead = "";
  late String hovLead = "";
  late String rawLead = "";
  late String zip = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data.zipCode.toString()!=null) {
      zip = widget.data.zipCode.toString();
    }
    loadData(widget.data.zipCode.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffFDF9FF),
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
          child: ListView(
            children: [
              
              Row(
                children: [

                  Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "#${widget.data.zipCode.toString()}",
                        style: const TextStyle(
                            fontSize: 30, color: Color(0Xff00A18A)),
                      )
                  ),
                ],
              ),
              
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeadDetailsList(leadType: "Warm lead", zipCode: zip, lt : "warm_lead"),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Warm Lead',
                          style: TextStyle(
                              fontSize: 20, color: Color(0Xff634099)),
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            warmLead,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Color(0Xff434141)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeadDetailsList(leadType: "Home Owner Verified", zipCode: zip, lt : "hovl_lead"),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Home Owner Verified',
                          style: TextStyle(
                              fontSize: 20, color: Color(0Xff634099)),
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            hovLead,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Color(0Xff434141)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeadDetailsList(leadType: "Raw Lead", zipCode: zip, lt : "raw_lead"),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Raw Lead',
                          style: TextStyle(
                              fontSize: 20, color: Color(0Xff634099)),
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            rawLead,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Color(0Xff434141)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Future<void> loadData(String zipCode) async {

    var response;



    var cartBody = {
      "zip_code": zipCode,
    };

    response = await BaseClient()
        .postWithToken('client/zip/details', cartBody)
        .catchError((err) {
      debugPrint('error: $err');
    });


    if (response == null) {
      showSnackBar('failed to get response');
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      setState(() {

        warmLead = allDatum.warmLeadsCount.toString();
        hovLead = allDatum.hovlLeadsCount.toString();
        rawLead = allDatum.rawLeadsCount.toString();

      });
    }
    else{
      showSnackBar(allDatum.message.toString());
    }

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
