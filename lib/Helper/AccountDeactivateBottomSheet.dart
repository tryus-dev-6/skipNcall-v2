
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';
import '../Pages/Login.dart';
import '../Util/Constants.dart';
import 'SharedPreferencesHelper.dart';
import 'dialog_helper.dart';

class DeactivateAccountDialog extends StatefulWidget {

  Function(String) onPressed;

  DeactivateAccountDialog({super.key, required this.onPressed});

  @override
  State<DeactivateAccountDialog> createState() => _DeactivateAccountDialogState();
}

class _DeactivateAccountDialogState extends State<DeactivateAccountDialog> {

  TextEditingController deactivatePasswordController = TextEditingController();
  TextEditingController deactivateTextController = TextEditingController();


  FocusNode deactivatePasswordFocusNode = FocusNode();
  FocusNode deactivateTextFocusNode = FocusNode();

  bool isPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      //height: 200,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
                padding: const EdgeInsets.only(right: 18, top: 15),
                alignment: Alignment.topRight,
                child: const Icon(
                    Icons.close, color: Color(0Xff8F8F8F)
                )
            ),
          ),

          Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Account Deactivate',
                    style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Please enter cause of deactivation',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  focusNode: deactivateTextFocusNode,
                  controller: deactivateTextController,

                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: 'Type your deactivation cause',
                    alignLabelWithHint: true,
                    labelStyle: (TextStyle(
                        color: Color(0Xff8F8F8F), fontSize: 14)),
                    iconColor: Color(0Xff8F8F8F),

                  ),
                  //keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  //textInputAction: TextInputAction.done,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Please enter your password',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  obscureText: isPasswordVisible,
                  focusNode: deactivatePasswordFocusNode,
                  controller: deactivatePasswordController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: 'Enter Your Password',
                    labelStyle: (const TextStyle(
                        color: Color(0Xff8F8F8F), fontSize: 14)),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                        // deactivateAccountCustomButtonSheet();
                      },
                    ),
                    iconColor: const Color(0Xff8F8F8F),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                    ),

                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      hideKeyboard();
                      deactivateAccount(context);
                    },
                  ),
                ),

                const SizedBox(height: 50),

              ],
            ),
          ),
        ],
      ),
    );
  }

  void hideKeyboard() {
    if (deactivateTextFocusNode.hasFocus) {
      deactivateTextFocusNode.unfocus(); // Remove focus from the text field
    }
    if (deactivatePasswordFocusNode.hasFocus) {
      deactivatePasswordFocusNode.unfocus(); // Remove focus from the text field
    }
  }

  Future<void> deactivateAccount(BuildContext context) async {

    String cause = deactivateTextController.text;
    String password = deactivatePasswordController.text;

    if(cause.isEmpty){

      flushBarErrorMessage("please enter you cause of deactivation");

      return;
    }
    if(password.isEmpty){

      flushBarErrorMessage("Enter your password");

      return;
    }

    DialogHelper.showLoading();

    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {
      "user_id": userId,
      "password": password,
      "deactivation_cause": cause
    };

    response = await BaseClient()
        .postWithToken('user/account/deactivate', profile)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      flushBarErrorMessage('failed to get response');
      DialogHelper.hideDialog();

      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      DialogHelper.hideDialog();
      successfulDeactivate(allDatum.message.toString());
      toLogInPage(context);

    } else {

      DialogHelper.hideDialog();
      if (allDatum.message != null) {
        flushBarErrorMessage(allDatum.message.toString());
      }
      if(allDatum.isTokenValid == false) {

        toLogInPage(context);
      }
    }


  }

  void toLogInPage(BuildContext context) {
    SharedPreferencesHelper.clearAllData();
    Get.offAllNamed('/login');
  }

  void successfulDeactivate(String message) {
    widget.onPressed(message);
    // Navigator.pop(context);
    Navigator.pop(context);
  }

  void flushBarErrorMessage(String message){

    showFlushbar(
        context: context,
        flushbar: Flushbar(

          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(10),
          message: message,
          duration: const Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeOut,
          borderRadius: BorderRadius.circular(10),
          positionOffset: 20,
          icon: const Icon(Icons.error, size: 28, color: Colors.white),

        )..show(context)
    );

  }

}
