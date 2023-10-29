
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Util/ColorCodes.dart';
import 'package:skip_n_call/Util/Tools.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';


class PayableLead extends StatefulWidget {
  const PayableLead({super.key});

  @override
  State<PayableLead> createState() => _PayableLeadState();
}

class _PayableLeadState extends State<PayableLead> {

  int warmLeadSelected = 0;
  int hovLeadSelected = 0;
  int rawLeadSelected = 0;

  int warmLeadCount = 0;
  int hovLeadCount = 0;
  int rawLeadCount = 0;

  Color warmLeadColor = color0;
  Color hovLeadColor = color0;
  Color rawLeadColor = color0;

  Color warmLeadTColor = color2;
  Color hovLeadTColor = color2;
  Color rawLeadTColor = color2;

  Color warmLeadBgColor = Colors.white;
  Color hovLeadBgColor = Colors.white;
  Color rawLeadBgColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


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
                            GestureDetector(
                              onTap: (){
                                performSelection(1);
                              },
                              child: Card(
                                color: warmLeadBgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                elevation: 5,
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Warm Lead",
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 20, color: warmLeadColor),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Unpaid Lead - $warmLeadCount",
                                          style: TextStyle(
                                              fontSize: 15, color: warmLeadTColor),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Payable - \$500",
                                          style: TextStyle(
                                              fontSize: 15, color: warmLeadTColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                performSelection(2);
                              },
                              child: Card(
                                color: hovLeadBgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                elevation: 5,
                                child: Container(
                                  margin: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Home Owner Verified",
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            fontSize: 20, color: hovLeadColor),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Unpaid Lead - $hovLeadCount",
                                          style: TextStyle(
                                              fontSize: 15, color: hovLeadTColor),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Payable - \$500",
                                          style: TextStyle(
                                              fontSize: 15, color: hovLeadTColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                performSelection(3);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Card(
                                  color: rawLeadBgColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                  elevation: 5,
                                  child: Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Raw Lead",
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              fontSize: 20, color: rawLeadColor),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Unpaid Lead - $rawLeadCount",
                                            style: TextStyle(
                                                fontSize: 15, color: rawLeadTColor),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Payable - \$500",
                                            style: TextStyle(
                                                fontSize: 15, color: rawLeadTColor),
                                          ),
                                        ),
                                      ],
                                    ),
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

  void performSelection(int i) {

    if (i == 1){
      if(warmLeadSelected == 1){

        setState(() {

          warmLeadColor = color0;
          warmLeadTColor = color2;
          warmLeadBgColor = Colors.white;

        });

        warmLeadSelected = 0;

      }
      else{

        setState(() {

          warmLeadColor = Colors.white;
          warmLeadTColor = Colors.white;
          warmLeadBgColor = color1;

        });

        warmLeadSelected = 1;

      }
    }
    if(i == 2){
      if(hovLeadSelected == 1){

        setState(() {

          hovLeadColor = color0;
          hovLeadTColor = color2;
          hovLeadBgColor = Colors.white;

        });

        hovLeadSelected = 0;

      }
      else{

        setState(() {

          hovLeadColor = Colors.white;
          hovLeadTColor = Colors.white;
          hovLeadBgColor = color1;

        });

        hovLeadSelected = 1;

      }
    }
    if(i == 3){

      if(rawLeadSelected == 1){

        setState(() {

          rawLeadColor = color0;
          rawLeadTColor = color2;
          rawLeadBgColor = Colors.white;

        });

        rawLeadSelected = 0;

      }
      else{

        setState(() {

          rawLeadColor = Colors.white;
          rawLeadTColor = Colors.white;
          rawLeadBgColor = color1;

        });

        rawLeadSelected = 1;

      }

    }
  }

  Future<void> loadData() async {

    var response;
    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);



    var cartBody = {
      "client_id": userId
    };

    response = await BaseClient()
        .postWithToken('client/payable/lead/count', cartBody)
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

        hovLeadCount = allDatum.hovlLeadsCount!;
        warmLeadCount = allDatum.warmLeadsCount!;
        rawLeadCount = allDatum.rawLeadsCount!;

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
