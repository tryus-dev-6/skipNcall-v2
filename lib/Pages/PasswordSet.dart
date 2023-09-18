import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Components/custom_button.dart';
import '../Components/custom_button2.dart';
import '../api/base_client.dart';
import '../helper/dialog_helper.dart';

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

  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // Set status bar color
      statusBarIconBrightness: Brightness.dark, // Change icon color
    ));

    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // final String username = args?['username'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomButton2(
                        icon: Icons.arrow_back_ios_new,
                        onPressed: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(
                                context); // Navigate back to the previous page
                          }
                        }),
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
                    const SizedBox(height: 5),
                    const Text(
                        "Please enter verification code and password to set new password. Check your email inbox or spam box for email.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 30),
                    // CustomButton(
                    //   text: 'Set Password',
                    //   icon: Icons.arrow_forward,
                    //   onPressed: () async {
                    //     String otp = otpController.text;
                    //     String password = passwordController.text;
                    //     String confirmPassword = confirmPasswordController.text;
                    //
                    //     if (otp.isEmpty) {
                    //       DialogHelper.showSnackBar(context,
                    //           "Please enter the verification code", "Okay", 1);
                    //       return;
                    //     }
                    //
                    //     if (password.isEmpty) {
                    //       DialogHelper.showSnackBar(
                    //           context, "Please enter the password", "Okay", 1);
                    //       return;
                    //     }
                    //
                    //     if (confirmPassword.isEmpty) {
                    //       DialogHelper.showSnackBar(context,
                    //           "Please enter the confirm password", "Okay", 1);
                    //       return;
                    //     }
                    //
                    //     if (password != confirmPassword) {
                    //       DialogHelper.showSnackBar(
                    //           context,
                    //           "Confirm password doesn't match with password",
                    //           "Okay",
                    //           1);
                    //       return;
                    //     }
                    //
                    //     var userData = {
                    //       "code": otp,
                    //       "username": username,
                    //       "new_password": password
                    //     };
                    //
                    //     hideKeyboard();
                    //     DialogHelper.showLoading();
                    //     var response = await BaseClient()
                    //         .post('check/v/code', userData)
                    //         .catchError((err) {});
                    //     if (response == null) {
                    //       debugPrint('failed');
                    //       DialogHelper.hideDialog();
                    //       return;
                    //     }
                    //     var res = json.decode(response);
                    //     DialogHelper.showSnackBar(
                    //         context, res["message"], "Okay", 5);
                    //
                    //     DialogHelper.hideDialog();
                    //     debugPrint('successful: $res');
                    //     if (res["status"] == true) {
                    //       Timer(
                    //           const Duration(seconds: 1),
                    //           () => Get.offAllNamed('/dashboard'));
                    //     }
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
