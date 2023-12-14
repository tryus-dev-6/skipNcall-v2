
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Model/CartListData.dart';
import 'package:skip_n_call/Pages/LeadDetailsList.dart';

import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';
import '../Util/ColorCodes.dart';

class ZipDetails extends StatefulWidget {

  const ZipDetails({super.key});

  @override
  State<ZipDetails> createState() => _ZipDetailsState();
}

class _ZipDetailsState extends State<ZipDetails> {

  late String warmLead = "";
  late String hovLead = "";
  late String rawLead = "";
  late String zip = "";

  Datum data = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = Get.arguments;

    if(data.zipCode.toString()!=null) {
      zip = data.zipCode.toString();
    }
    loadData(data.zipCode.toString());
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
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: color0,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: color0),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              
              Row(
                children: [

                  Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "#${data.zipCode.toString()}",
                        style: const TextStyle(
                            fontSize: 30, color: Color(0Xff00A18A)),
                      )
                  ),
                ],
              ),
              
              GestureDetector(
                onTap: (){

                  Get.toNamed("/leadDetailsList", arguments: ["Warm lead", zip, "warm_lead"]);

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

                  Get.toNamed("/leadDetailsList", arguments: ["Home Owner Verified", zip, "hovl_lead"]);

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

                  Get.toNamed("/leadDetailsList", arguments: ["Raw Lead", zip, "raw_lead"]);

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
