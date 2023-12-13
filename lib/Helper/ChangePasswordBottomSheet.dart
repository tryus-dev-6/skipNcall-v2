import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:skip_n_call/Pages/Login.dart';

import '../Api/base_client.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';
import 'SharedPreferencesHelper.dart';
import 'dialog_helper.dart';

class ChangePasswordBottomSheet extends StatefulWidget {

  Function(String) onPressed;

  ChangePasswordBottomSheet({super.key, required this.onPressed});

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();

  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();

  bool isNewPasswordVisible = false;
  bool isCurrentPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNewPasswordVisible = true;
    isCurrentPasswordVisible = true;
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
  }


  void hideKeyboard() {
    if (currentPasswordFocusNode.hasFocus) {
      currentPasswordFocusNode.unfocus(); // Remove focus from the text field
    }
    if (newPasswordFocusNode.hasFocus) {
      newPasswordFocusNode.unfocus(); // Remove focus from the text field
    }
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
                    'Change Password',
                    style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Please enter your Current Password',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  obscureText: isCurrentPasswordVisible,
                  focusNode: currentPasswordFocusNode,
                  controller: currentPasswordController,
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
                      icon: Icon(isCurrentPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isCurrentPasswordVisible = !isCurrentPasswordVisible;
                        });
                        // deactivateAccountCustomButtonSheet();
                      },
                    ),
                    iconColor: const Color(0Xff8F8F8F),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Please enter your new Password',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  obscureText: isNewPasswordVisible,
                  focusNode: newPasswordFocusNode,
                  controller: newPasswordController,
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
                      icon: Icon(isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
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
                      updatePassword(context);
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

  Future<void> updatePassword(BuildContext context) async {

    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;

    if(currentPassword.isEmpty){
      Tools.flushBarErrorMessage("Enter Password", context);

      return;
    }
    if(newPassword.isEmpty){
      Tools.flushBarErrorMessage("Enter Password", context);

      return;
    }

    DialogHelper.showLoading();

    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {
      "user_id": userId,
      "new_password": newPassword,
      "old_password": currentPassword
    };

    response = await BaseClient()
        .postWithToken('user/change/password', profile)
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
      successfulUpdate(allDatum.message.toString());

    } else {

      DialogHelper.hideDialog();
      if (allDatum.message != null) {
        flushBarErrorMessage(allDatum.message.toString());
      }
      if(allDatum.isTokenValid == false) {

        toLogInPage();
      }
    }


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

  void toLogInPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ), (Route route) => false);
  }

  void successfulUpdate(String message) {
    widget.onPressed(message);
    // Navigator.pop(context);
    Navigator.pop(context);
  }

}
