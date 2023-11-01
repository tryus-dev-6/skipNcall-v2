import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Helper/AccountDeactivateBottomSheet.dart';
import 'package:skip_n_call/Helper/ChangePasswordBottomSheet.dart';

import 'EditProfile.dart';

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

  void hideKeyboard() {
    // if (usernameFocusNode.hasFocus) {
    //   usernameFocusNode.unfocus(); // Remove focus from the text field
    // }
    // if (passwordFocusNode.hasFocus) {
    //   passwordFocusNode.unfocus(); // Remove focus from the text field
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0Xff634099),
      statusBarIconBrightness: Brightness.light,
    ));

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: const BackButton(
              color: Color(0Xff634099), // <-- SEE HERE
            ),
            centerTitle: true,
            title: const Text("Profile",
                style: TextStyle(
                  color: Color(0Xff634099),
                )),
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
                            const SizedBox(
                              width: 90,
                              height: 90,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/ic_user2.png'),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EditProfile(),
                                    ),
                                  );
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15),
                  child: const Column(
                    children: [
                      Text(
                        'Abdulla Al Mued',
                        style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                      ),
                      Text(
                        'abdullaalmuid101@gmail.com',
                        style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
                      ),
                      Text(
                        '01831553096',
                        style: TextStyle(fontSize: 14, color: Color(0Xff696969)),
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
                      right: 15, left: 15, top: 20, bottom: 15),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
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
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(5),
                              child: const Text(
                                '\$ 12,2545',
                                style: TextStyle(fontSize: 20, color: Colors.white),
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
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                            Container(

                              margin: const EdgeInsets.all(5),
                              child: const Text(
                                '122',
                                style: TextStyle(fontSize: 20, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, color: Color(0Xff434141)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
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
                                shape: BoxShape.circle, // This makes the container circular
                                color: Color(0Xff00A18A),    // You can change the color as needed
                              ),

                              child: SvgPicture.asset(
                                'assets/images/ic_change_password.svg',
                                color: Colors.white,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.scaleDown
                              ),
                            ),
                            const Text(
                              'Change Password',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0Xff424853)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, right: 25),
                          child: SvgPicture.asset(
                            'assets/images/ic_right.svg',
                            height: 25,
                            width: 20,
                            color: const Color(0Xff424853),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
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
                    margin: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
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
                                shape: BoxShape.circle, // This makes the container circular
                                color: Color(0XffFFB100),    // You can change the color as needed
                              ),

                              child: const Icon(
                                Icons.email,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Change Email Address',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0Xff424853)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, right: 25),
                          child: SvgPicture.asset(
                            'assets/images/ic_right.svg',
                            height: 25,
                            width: 20,
                            color: const Color(0Xff424853),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0XffEFEFEF),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    margin: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
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
                                shape: BoxShape.circle, // This makes the container circular
                                color: Color(0Xff634099),    // You can change the color as needed
                              ),

                              child: const Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0Xff424853)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, right: 25),
                          child: SvgPicture.asset(
                            'assets/images/ic_right.svg',
                            height: 25,
                            width: 20,
                            color: const Color(0Xff424853),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
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
                    margin: const EdgeInsets.only(right: 15, left: 15, bottom: 45),
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
                                shape: BoxShape.circle, // This makes the container circular
                                color: Color(0Xff3967B1),    // You can change the color as needed
                              ),

                              child: const Icon(
                                Icons.account_circle_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Deactivate Account',
                              style: TextStyle(
                                  fontSize: 18, color: Color(0Xff424853)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, right: 25),
                          child: SvgPicture.asset(
                            'assets/images/ic_right.svg',
                            height: 25,
                            width: 20,
                            color: const Color(0Xff424853),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    ));
  }


  void showCustomBottomSheet(){

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const ChangePasswordBottomSheet();
      },
    );
  }

  void changeEmailCustomButtonSheet(){

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
                        'Change Email',
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

  void deactivateAccountCustomButtonSheet(){

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const DeactivateAccountDialog();
      },
    );
  }

}

