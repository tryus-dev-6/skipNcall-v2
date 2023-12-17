import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skip_n_call/Pages/Login.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';


class PasswordSet extends StatefulWidget {

  const PasswordSet({super.key});

  @override
  State<PasswordSet> createState() => _PasswordSetState();
}

class _PasswordSetState extends State<PasswordSet> {
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode otpFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  late String user;
  BuildContext? mContext;


  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
    isConfirmPasswordVisible = true;
    user = Get.arguments.toString();
  }

  @override
  void dispose() {
    otpFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    passwordFocusNode.dispose();
    otpController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    if (otpFocusNode.hasFocus) {
      otpFocusNode.unfocus(); // Remove focus from the text field
    }
    if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus(); // Remove focus from the text field
    }
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus(); // Remove focus from the text field
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color(0Xff634099),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white
    ));

    mContext = context;

    return Scaffold(
      backgroundColor: const Color(0XffFDF9FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Column(
                  children: [
                    SizedBox(height: 20),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Forget Password",
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)),
                        // SvgPicture.asset(
                        //   'assets/images/logo.svg',
                        //   width: 60,
                        //   color: const Color(0Xff634099),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                        "Please enter verification code and password to set new password. Check your email inbox or spam box for email. code will expire after 3 minutes",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    const SizedBox(height: 15),
                    const Text(
                        "code will expire after 3 minutes",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                    const SizedBox(height: 40),
                    TextField(
                      controller: otpController,
                      focusNode: otpFocusNode,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Enter Verification Code',
                          prefixIcon:
                              Icon(Icons.message, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14))),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: isPasswordVisible,
                      focusNode: passwordFocusNode,
                      controller: passwordController,
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
                            setState(
                              () {
                                isPasswordVisible = !isPasswordVisible;
                              },
                            );
                          },
                        ),
                        iconColor: const Color(0Xff8F8F8F),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      obscureText: isConfirmPasswordVisible,
                      focusNode: confirmPasswordFocusNode,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Enter Your Confirm Password',
                        labelStyle: (const TextStyle(
                            color: Color(0Xff8F8F8F), fontSize: 14)),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                              () {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              },
                            );
                          },
                        ),
                        iconColor: const Color(0Xff8F8F8F),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                            ),
                          ),

                        ),
                        onPressed: () {
                          passwordSet();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            "Didn't received?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        GestureDetector(

                          onTap: (){
                            sendOtp(user);
                          },

                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                                "Resend ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0Xff634099),
                                )),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendOtp(String email) async {



    var sendOtp = {
      "email": email
    };

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .post('user/reset/password', sendOtp)
        .catchError((err) {
      DialogHelper.hideDialog();
      Tools.flushBarErrorMessage(err.toString(), mContext!);
    });
    if (response == null) {
      debugPrint('failed');
      DialogHelper.hideDialog();
      return;
    }
    var res = json.decode(response);
    DialogHelper.hideDialog();
    debugPrint('successful: $res');
    CommonResponse commonResponse = allDataFromJson(response);
    if (commonResponse.status == true) {

      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_ACCESS_TOKEN, commonResponse.token.toString());

      Tools.flushBarSuccessMessage(commonResponse.message!, mContext!);

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }else{
      Tools.flushBarErrorMessage(commonResponse.message!, mContext!);
    }

  }

  Future<void> passwordSet() async {

    String code = otpController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;


    if (code.isEmpty) {
      Tools.flushBarErrorMessage("Please enter the otp", mContext!);
      return;
    }
    if (password.isEmpty) {
      Tools.flushBarErrorMessage("Please enter the password", mContext!);
      return;
    }
    if (password.length<8) {
      Tools.flushBarErrorMessage("password At least 8 characters required", mContext!);
      return;
    }
    if (confirmPassword.isEmpty) {
      Tools.flushBarErrorMessage("Please enter confirmation password", mContext!);
      return;
    }
    if (confirmPassword != password) {
      Tools.flushBarErrorMessage("Password unmatched", mContext!);
      return;
    }



    var resetPassword = {
      "email": user,
      "code": code,
      "new_password": password
    };

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .postWithToken('user/check/code', resetPassword)
        .catchError((err) {
      DialogHelper.hideDialog();
      Tools.flushBarErrorMessage(err.toString(), mContext!);
    });
    if (response == null) {
      debugPrint('failed');
      DialogHelper.hideDialog();
      return;
    }
    var res = json.decode(response);

    DialogHelper.hideDialog();
    debugPrint('successful: $res');
    CommonResponse commonResponse = allDataFromJson(response);
    if (commonResponse.status == true) {

      successSetPassword();

      Tools.flushBarSuccessMessage(commonResponse.message!, mContext!);

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }else{
      Tools.flushBarErrorMessage(commonResponse.message!, mContext!);
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
          //SnackbarController.closeCurrentSnackbar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void successSetPassword() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed("/login");
    });
  }



}
