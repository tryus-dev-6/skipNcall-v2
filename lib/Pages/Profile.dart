import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Helper/AccountDeactivateBottomSheet.dart';
import 'package:skip_n_call/Helper/ChangePasswordBottomSheet.dart';
import 'package:skip_n_call/Pages/ChangeEmail.dart';
import 'package:skip_n_call/Util/Tools.dart';

import '../Api/Constants.dart';
import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Util/ColorCodes.dart';
import '../Util/Constants.dart';
import 'EditProfile.dart';
import 'Login.dart';

enum SampleItem { itemOne }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  SampleItem? selectedMenu;

  bool isPasswordVisible = false;
  bool isDeactivatePasswordVisible = false;

  String? currentImage,
      firstname = "",
      lastname = "",
      email = "",
      phone = "",
      balance = "";
  int totalZip = 0;

  void hideKeyboard() {
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    emailController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPasswordVisible = true;
    initiateUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white, // <-- SEE HERE
          ),
          centerTitle: true,
          title: const Text("Profile",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: color0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: color0,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: color0),
        ),
        body: Container(
          color: const Color(0XffFDF9FF),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: currentImage != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(currentImage!),
                                    backgroundColor: Colors.white,
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/ic_user2.png'),
                                    backgroundColor: Colors.white,
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/editProfile");
                              },
                              child: Card(
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 10),
                                  color: const Color(0Xff00A18A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    height: 25,
                                    width: 25,
                                    child: SvgPicture.asset(
                                      'assets/images/ic_edit.svg',
                                      height: 10,
                                      width: 10,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      "${firstname!} ${lastname!}",
                      style: const TextStyle(
                          fontSize: 20, color: Color(0Xff434141)),
                    ),
                    SizedBox(height: 3),
                    Text(
                      email.toString(),
                      style: const TextStyle(
                          fontSize: 14, color: Color(0Xff696969)),
                    ),
                    Text(
                      phone ?? "",
                      style: const TextStyle(
                          fontSize: 14, color: Color(0Xff696969)),
                    ),
                  ],
                ),
              ),
              Card(
                color: const Color(0Xff634099),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.only(
                    right: 15, left: 15, top: 0, bottom: 10),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              'Balance',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              '\$ $balance',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              'Total Zips',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: Text(
                              totalZip.toString(),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 15),
                child: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, color: Color(0Xff434141)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showCustomBottomSheet();
                },
                child: Card(
                  color: const Color(0XffEFEFEF),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.only(
                      right: 15, left: 15, top: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 15, right: 10),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape
                                  .circle, // This makes the container circular
                              color: Color(
                                  0Xff00A18A), // You can change the color as needed
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                  'assets/images/ic_change_password.svg',
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                          const Text(
                            'Change Password',
                            style: TextStyle(
                                fontSize: 16, color: Color(0Xff424853)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, right: 25),
                        child: SvgPicture.asset(
                          'assets/images/ic_right.svg',
                          height: 20,
                          width: 10,
                          color: const Color(0Xff424853),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  changeEmailCustomButtonSheet();
                },
                child: Card(
                  color: const Color(0XffEFEFEF),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 15, right: 10),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape
                                  .circle, // This makes the container circular
                              color: Color(
                                  0XffFFB100), // You can change the color as needed
                            ),
                            child: const Icon(
                              Icons.email,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Change Email Address',
                            style: TextStyle(
                                fontSize: 16, color: Color(0Xff424853)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, right: 25),
                        child: SvgPicture.asset(
                          'assets/images/ic_right.svg',
                          height: 20,
                          width: 10,
                          color: const Color(0Xff424853),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed("/editProfile");
                },
                child: Card(
                  color: const Color(0XffEFEFEF),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 15, right: 10),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape
                                  .circle, // This makes the container circular
                              color: Color(
                                  0Xff634099), // You can change the color as needed
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 16, color: Color(0Xff424853)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, right: 25),
                        child: SvgPicture.asset(
                          'assets/images/ic_right.svg',
                          height: 20,
                          width: 10,
                          color: const Color(0Xff424853),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  deactivateAccountCustomButtonSheet();
                },
                child: Card(
                  color: const Color(0XffEFEFEF),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  margin:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 15.0, bottom: 15.0, left: 15, right: 10),
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape
                                  .circle, // This makes the container circular
                              color: Color(
                                  0Xff3967B1), // You can change the color as needed
                            ),
                            child: const Icon(
                              Icons.account_circle_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Deactivate Account',
                            style: TextStyle(
                                fontSize: 16, color: Color(0Xff424853)),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, right: 25),
                        child: SvgPicture.asset(
                          'assets/images/ic_right.svg',
                          height: 20,
                          width: 10,
                          color: const Color(0Xff424853),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> initiateUserInfo() async {
    //DialogHelper.showLoading();

    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {"client_id": userId};

    response = await BaseClient()
        .postWithToken('client/profile', profile)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      showSnackBar('failed to get response');
      DialogHelper.hideDialog();

      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      firstname = allDatum.user!.firstName.toString();
      lastname = allDatum.user!.lastName.toString();
      totalZip = allDatum.user!.totalZip!;
      balance = allDatum.user!.clientBalance.toString();
      String mail = allDatum.user!.email =
          await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_EMAIL);
      String ph = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_PHONE);

      setState(() {
        if (allDatum.user?.proPic != null) {
          currentImage = Constants.IMAGE_URL + allDatum.user?.proPic;
        }
        email = mail;
        phone = ph;
      });
    } else {
      if (allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
      if (allDatum.isTokenValid == false) {
        toLogInPage();
      }
    }

    //DialogHelper.hideDialog();
  }

  void showCustomBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ChangePasswordBottomSheet(onPressed: (String message) {
          setState(() {
            showSnackBar(message);
          });
        });
      },
    );
  }

  void changeEmailCustomButtonSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: const EdgeInsets.only(right: 18, top: 15),
                    alignment: Alignment.topRight,
                    child: const Icon(Icons.close, color: Color(0Xff8F8F8F))),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Change Email',
                        style:
                            TextStyle(fontSize: 25, color: Color(0Xff383737)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'Please enter your email',
                        style:
                            TextStyle(fontSize: 14, color: Color(0Xff383737)),
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
                        labelStyle:
                            (TextStyle(color: Color(0Xff8F8F8F), fontSize: 14)),
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
                          backgroundColor:
                              const MaterialStatePropertyAll(Color(0Xff634099)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          sendOtp();
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

  void successSendOtp() {
    Get.toNamed("/changeEmail", arguments: emailController.text.toString());
  }

  void deactivateAccountCustomButtonSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DeactivateAccountDialog(onPressed: (String message) {
          setState(() {
            showSnackBar(message);
          });
        });
      },
    );
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
      ),
      duration: const Duration(seconds: 2),
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

  Future<void> sendOtp() async {
    if (emailController.text.isEmpty) {
      showFlushBar("please enter your email address");

      return;
    }

    String? userId =
        await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var sendOtp = {"user_id": userId, "email": emailController.text.toString()};

    hideKeyboard();
    DialogHelper.showLoading();
    var response = await BaseClient()
        .postWithToken('client/change/email', sendOtp)
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
    DialogHelper.hideDialog();
    debugPrint('successful: $res');
    CommonResponse commonResponse = allDataFromJson(response);
    if (commonResponse.status == true) {
      Navigator.pop(context);
      showFlushBar(commonResponse.message.toString());
      successSendOtp();
    } else {
      showFlushBar(commonResponse.message.toString());

      if (commonResponse.isTokenValid == false) {
        tokenInvalid();
      }
    }
  }

  void showFlushBar(String message) {
    Tools.flushBarErrorMessage(message, context);
  }

  void tokenInvalid() {
    Future.delayed(const Duration(seconds: 2), () {
     Get.offAllNamed("/login");
    });
  }

  void toLogInPage() {
    SharedPreferencesHelper.removeData(SKIP_N_CALL_USER_USERID);

    Get.offAllNamed("/login");

  }
}
