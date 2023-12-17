
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:skip_n_call/Pages/PasswordSet.dart';
import 'package:skip_n_call/Pages/SignUp.dart';
import 'package:skip_n_call/Util/ColorCodes.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Model/User.dart';
import '../Util/Constants.dart';
import '../Util/NotificationService.dart';
import '../Util/Tools.dart';
import 'Home.dart';
import 'Navigation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isUserNameValidate = false;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  NotificationService notificationService = NotificationService();
  String token = "";

  BuildContext? mContext;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;

    notificationService.getDeviceToken().then((value) => {

      print("Device Token$value"),
      token = value

    });

  }

  // @override
  // void dispose() {
  //   usernameFocusNode.dispose();
  //   passwordFocusNode.dispose();
  //   emailFocusNode.dispose();
  //
  //
  //   usernameController.dispose();
  //   passwordController.dispose();
  //   //usernameController.dispose();
  //   super.dispose();
  // }

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

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: color0, // Set status bar color
      statusBarIconBrightness: Brightness.light, // Change icon color
      systemNavigationBarColor: color0, // Change system navigation bar color
    ));

    mContext = context;

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
                              //forgetPassword();
                              showCustomButtonSheet();
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

                          GestureDetector(

                            onTap: () {
                              Get.toNamed("/signUp");
                            },

                            child: Container(
                              padding: const EdgeInsets.only(right: 20, top: 15, bottom: 15, left: 10),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0Xff623E99),
                                ),
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
      Tools.flushBarErrorMessage("Please enter the email or phone", mContext!);
      return;
    }
    debugPrint("Username $username");

    if (password.isEmpty) {
      Tools.flushBarErrorMessage("Please enter the password", mContext!);

      return;
    }
    debugPrint("Password $password");

    print("Device Token$token");

    var userData = {
      "email": username,
      "password": password,
      "notification_token": token
    };

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .post('login', userData)
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

      Tools.flushBarSuccessMessage(commonResponse.message!, mContext!);

      User? user = commonResponse.user;
      debugPrint('user_id: ${user!.userId}');
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_USERID, user.userId??"");
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_FIRSTNAME, user.firstName??"");
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_LASTNAME, user.lastName??"");
      //SharedPreferencesHelper.saveData(TSF_USER_PROFILE_PICTURE, user.proPic.toString());
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_ACCESS_TOKEN, commonResponse.token??"");
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_EMAIL, user.email??"");
      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_PHONE, user.phone??"");

      logInSuccess();

      //showSnackBar("Please enter the password");

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }
    else
      {
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

  void logInSuccess() {
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed("/home");
    });
  }

  // void forgetPassword() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const PasswordSet(),
  //     ),
  //   );
  // }


  void showCustomButtonSheet(){

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext context) {
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
                        'Forgot Password',
                        style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Please enter your email',
                        style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                      ),
                    ),

                    const SizedBox(height: 30),
                    TextField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'Enter Email',
                        labelStyle: (TextStyle(
                            color: Color(0Xff8F8F8F), fontSize: 14)),
                        prefixIcon: Icon(Icons.email),
                        iconColor: Color(0Xff8F8F8F),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                          sendOtp(emailController.text.toString());
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
      },
    );
  }

  Future<void> sendOtp(String email) async {



    if (email.isEmpty) {

      MotionToast.error(
        description: const Text("please enter you email"),
      ).show(context);

      return;
    }



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
    //showSnackBar(res["message"]);
    DialogHelper.hideDialog();
    debugPrint('successful: $res');
    CommonResponse commonResponse = allDataFromJson(response);
    if (commonResponse.status == true) {

      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_ACCESS_TOKEN, commonResponse.token.toString());

      successOtpSend(email);

      Tools.flushBarSuccessMessage(commonResponse.message!, mContext!);

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }else{
      failed(commonResponse.message!);
    }

  }

  void successOtpSend(String? email) {

    Navigator.pop(context);

    Future.delayed(const Duration(seconds: 1), () {
      Get.toNamed("/passwordSet", arguments: email!);
    });
  }


  void failed(String message) {
    MotionToast.error(
      description: Text(message),
    ).show(context);
  }

}
