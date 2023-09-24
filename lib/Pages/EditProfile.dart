

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:skip_n_call/Api/Constants.dart';
import 'package:skip_n_call/Pages/Navigation.dart';
import 'package:skip_n_call/Pages/Profile.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Util/Constants.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  File? selectedImage;
  String? currentImage;


  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    initiateUserInfo();
    super.initState();
  }

  void hideKeyboard() {

    if (firstNameFocusNode.hasFocus) {
      firstNameFocusNode.unfocus();
    }if (lastNameFocusNode.hasFocus) {
      lastNameFocusNode.unfocus();
    }
    if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
    if (phoneFocusNode.hasFocus) {
      phoneFocusNode.unfocus();
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: const BackButton(
              color: Color(0Xff634099),
            ),
            centerTitle: true,
            title: const Text("Edit Profile",
                style: TextStyle(
                  color: Color(0Xff634099),
                )
            ),
            backgroundColor: const Color(0XffFDF9FF),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0XffFDF9FF),
            ),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
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
                              child:selectedImage != null
                                  ? CircleAvatar(
                                backgroundImage: FileImage(selectedImage!),
                                backgroundColor: Colors.white,
                              ) :
                              currentImage != null? CircleAvatar(
                                backgroundImage:NetworkImage(currentImage!),
                                backgroundColor: Colors.white,
                              ) : const CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/images/ic_user2.png'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: (){
                                  pickImageFromGallery();
                                },
                                child: Card(
                                    margin:
                                    const EdgeInsets.only(right: 10, bottom: 10),
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
                          labelText: 'First Name',
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
                          labelText: 'Last Name',
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
                        enabled: false,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: 'Email',

                          labelStyle: (TextStyle(color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon: Icon(Icons.email, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                            filled: true,
                            fillColor: CupertinoColors.lightBackgroundGray
                        ),
                        keyboardType: TextInputType.emailAddress,

                      ),
                      const SizedBox(height: 10),
                      TextField(
                        focusNode: phoneFocusNode,
                        controller: phoneController,
                        enabled: false,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: 'Phone',
                          labelStyle: (TextStyle(
                              color: Color(0Xff8F8F8F), fontSize: 14)),
                          prefixIcon:
                          Icon(Icons.phone, color: Color(0Xff8F8F8F)),
                          iconColor: Color(0Xff8F8F8F),
                          filled: true,
                          fillColor: CupertinoColors.lightBackgroundGray

                        ),
                        keyboardType: TextInputType.emailAddress,
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
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),

                          ),
                          onPressed: () {

                            updateUserInfo();
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Future<void> updateUserInfo() async {

    DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    // if (selectedImage == null){
    //   DialogHelper.hideDialog();
    //
    //   return;
    // }

    var request = http.MultipartRequest('POST', Uri.parse('${Constants.BASE_URL}client/edit/profile'));

    String? token = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_ACCESS_TOKEN);
    request.headers['Authorization'] = 'Bearer $token';

    if(selectedImage!=null) {
      request.files.add(await http.MultipartFile.fromPath('pro_pic', selectedImage!.path));
    }

    request.fields['client_id'] = userId;
    request.fields['first_name'] = firstNameController.text;
    request.fields['last_name'] = lastNameController.text;

    // Send the request with the image
    var response = await request.send();

    DialogHelper.hideDialog();

    if (response.statusCode == 200) {

      var responseBody = await response.stream.bytesToString();

      var res = json.decode(responseBody);

      CommonResponse allDatum = allDataFromJson(responseBody);

      showSnackBar(allDatum.message.toString());

      successUpload();

      debugPrint('successful: $res');
    } else {

      DialogHelper.hideDialog();
      showSnackBar("Something went wrong");
      debugPrint('Error Status Code: ${response.statusCode}');
      throw Exception('Request failed with status: ${response.statusCode}');
    }

    DialogHelper.hideDialog();

  }

  Future<void> initiateUserInfo() async {

    //DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {
      "client_id": userId
    };

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
      firstNameController.text = allDatum.user!.firstName.toString();
      lastNameController.text = allDatum.user!.lastName.toString();
      emailController.text = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_EMAIL);
      phoneController.text = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_PHONE);

      setState(() {
        currentImage = Constants.IMAGE_URL+allDatum.user?.proPic;
      });

    }
    else{
      if(allDatum.message != null) {
        showSnackBar(allDatum.message.toString());
      }
    }

    //DialogHelper.hideDialog();

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

  Future<void> pickImageFromGallery() async {

    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage == null) return;

    setState(() {
      selectedImage = File(returnedImage.path);
    });

  }

  void successUpload() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Navigation(index: 0),
      ),
    );

  }

}
