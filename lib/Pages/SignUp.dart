

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Pages/Login.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Model/User.dart';
import '../Util/Constants.dart';
import 'package:motion_toast/motion_toast.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailVerifyController = TextEditingController();
  late String email;
  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isUserNameValidate = false;
  String setStatus = "";

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode emailVerifyNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
    isConfirmPasswordVisible = true;
  }

  @override
  void dispose() {
    passwordFocusNode.dispose(); // Dispose the focus node to avoid memory leaks
    confirmPasswordFocusNode.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    emailVerifyNode.dispose();

    confirmPasswordController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    emailVerifyController.dispose();

    super.dispose();
  }

  void hideKeyboard() {
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus(); // Remove focus from the text field
    }if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus(); // Remove focus from the text field
    }
    if (firstNameFocusNode.hasFocus) {
      firstNameFocusNode.unfocus(); // Remove focus from the text field
    }if (lastNameFocusNode.hasFocus) {
      lastNameFocusNode.unfocus(); // Remove focus from the text field
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus(); // Remove focus from the text field
    }
    if (phoneFocusNode.hasFocus) {
      phoneFocusNode.unfocus(); // Remove focus from the text field
    }if (emailVerifyNode.hasFocus) {
      emailVerifyNode.unfocus(); // Remove focus from the text field
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: const Color(0XffFDF9FF),
          height: double.infinity,
          child: SafeArea(
            child: ListView(
              children: [
                Align(
                  alignment: FractionalOffset.topRight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 50, right: 20),
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 240,
                      color: const Color(0Xff634099),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      TextField(
                        focusNode: firstNameFocusNode,
                        controller: firstNameController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: 'Enter Your First Name',
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon:
                          Icon(Icons.account_circle_rounded, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: lastNameFocusNode,
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: 'Enter Your Last Name',
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon:
                          Icon(Icons.account_circle_rounded, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
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
                          labelText: 'Enter Your Email',
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon:
                          Icon(Icons.email, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: phoneFocusNode,
                        controller: phoneController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: 'Enter Your Phone',
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon:
                          Icon(Icons.phone, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 10),
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
                          labelText: 'Confirm Your Password',
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
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
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

                            submitSignUpInfo();
                            //showCustomButtonSheet();
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already Have Account?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0Xff383737),
                            ),
                          ),

                          GestureDetector(

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const Login(),
                                ),
                              );
                            },

                            child: Container(
                              padding: const EdgeInsets.only(right: 20, top: 15, bottom: 15, left: 10),
                              child: const Text(
                                "Login",
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


  void showCustomButtonSheet(){

    setStatus = '';

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
                        'Email Verification',
                        style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Please enter the 6 digit code from your submitted email',
                        style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                      ),
                    ),

                    const SizedBox(height: 30),
                    TextField(
                      focusNode: emailVerifyNode,
                      controller: emailVerifyController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'Enter code',
                        labelStyle: (TextStyle(
                            color: Color(0Xff8F8F8F), fontSize: 14)),
                        prefixIcon: Icon(Icons.code_rounded),
                        iconColor: Color(0Xff8F8F8F),
                      ),
                      keyboardType: TextInputType.number,
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
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                            ),
                          ),

                        ),

                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {

                          checkOtp();
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

  void resendCode () {}

  Future<void> checkOtp() async {

    String code = emailVerifyController.text;


    if (code.isEmpty) {

      MotionToast.error(
        description: const Text("please enter code"),
      ).show(context);

      return;
    }



    var userVerify = {
      "email": email,
      "code": code
    };

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .postWithToken('user/email/verification', userVerify)
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

      signInSuccess();

      showSnackBar(commonResponse.message!);

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }else{
      failed(commonResponse.message!);
    }

  }

  Future<void> submitSignUpInfo() async {

    String firstName = firstNameController.text;
    String password = passwordController.text;
    email = emailController.text;
    String lastName = lastNameController.text;
    String confirmPassword = confirmPasswordController.text;
    String phone = phoneController.text;

    if (firstName.isEmpty) {
      showSnackBar("Please enter the email or phone");
      return;
    }
    if (password.isEmpty) {
      showSnackBar("Please enter the password");
      return;
    }
    if (lastName.isEmpty) {
      showSnackBar("Please enter your last name");
      return;
    }
    if (email.isEmpty) {
      showSnackBar("Please enter your email");
      return;
    }
    if (confirmPassword.isEmpty) {
      showSnackBar("Please confirm your password");
      return;
    }
    if (phone.isEmpty) {
      showSnackBar("Please enter your phone number");
      return;
    }
    debugPrint("Password $password");

    var userData = {
      "first_name":firstName,
      "last_name":lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "pro_pic": '',
    };

    hideKeyboard();
    DialogHelper.showLoading();

    var response = await BaseClient()
        .post('register', userData)
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


      SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_ACCESS_TOKEN, commonResponse.token.toString());
      showCustomButtonSheet();
      //showSnackBar("Please enter the password");

      // Timer(
      //     const Duration(seconds: 1),
      //         () => Get.offAllNamed('/home'));
    }else{
      showSnackBar(commonResponse.message!);
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

  void signInSuccess() {

    Navigator.pop(context);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    });
  }

  void failed(String message) {
    MotionToast.error(
      description: Text(message),
    ).show(context);
  }


}

