import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Model/User.dart';
import '../Util/Constants.dart';
import 'CustomSheetResetPassword.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isUserNameValidate = false;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose(); // Dispose the focus node to avoid memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    if (usernameFocusNode.hasFocus) {
      usernameFocusNode.unfocus(); // Remove focus from the text field
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
    ));

    return Scaffold(
      body: Container(
        color: const Color(0XffFDF9FF),
        height: double.infinity,
        child: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 220.0,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      'assets/images/dashboard_bg.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 80.0,
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      color:
                      Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    TextField(
                      focusNode: usernameFocusNode,
                      controller: usernameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'Enter Your Email or Phone',
                        labelStyle: (TextStyle(
                            color: Color(0Xff8F8F8F), fontSize: 14)),
                        prefixIcon:
                        Icon(Icons.email, color: Color(0Xff8F8F8F)),
                        iconColor: Color(0Xff8F8F8F),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
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
                      textInputAction: TextInputAction.done,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, right: 5, bottom: 20, left: 5),
                      child: Align(
                        alignment: Alignment.centerRight, // Align to the right end
                        child: GestureDetector(

                          onTap: () {
                            showCustomButtonSheet(context);
                          },

                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0XffCA0303),
                            ),

                          ),
                        ),
                      ),
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
                          doLogIn();
                        },
                        child: const Text(
                            'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't Have Account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0Xff383737),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0Xff623E99),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> doLogIn() async {

    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty) {
      showSnackBar("Please enter the email or phone");
      return;
    }
    debugPrint("Username $username");

    if (password.isEmpty) {
      showSnackBar("Please enter the password");
      return;
    }
    debugPrint("Password $password");

    var userData = {
      "email": username,
      "password": password
    };

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .post('login', userData)
        .catchError((err) {
      DialogHelper.hideDialog();
      showSnackBar(err.toString());
    });
    if (response == null) {
      debugPrint('failed');
      DialogHelper.hideDialog();
      return;
    }
    var res = json.decode(response);
    showSnackBar(res["message"]);
    DialogHelper.hideDialog();
    debugPrint('successful: $res');
    CommonResponse commonResponse = allDataFromJson(response);
    if (commonResponse.status == true) {

      User? user = commonResponse.user;
      debugPrint('user_id: ${user!.userId}');
      SharedPreferencesHelper.saveData(TSF_USER_USERID, user.userId.toString());
      SharedPreferencesHelper.saveData(TSF_USER_FIRSTNAME, user.firstName.toString());
      SharedPreferencesHelper.saveData(TSF_USER_LASTNAME, user.lastName.toString());
      SharedPreferencesHelper.saveData(TSF_USER_PROFILE_PICTURE, user.proPic.toString());
      SharedPreferencesHelper.saveData(TSF_USER_ACCESS_TOKEN, commonResponse.token.toString());
      SharedPreferencesHelper.saveData(TSF_USER_EMAIL, user.email.toString());
      SharedPreferencesHelper.saveData(TSF_USER_PHONE, user.phone.toString());

      //showSnackBar("Please enter the password");

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
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
}
