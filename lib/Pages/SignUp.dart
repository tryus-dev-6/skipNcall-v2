

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Pages/Login.dart';

import '../CustomDialogues/CustomSheetResetPassword.dart';


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

  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isUserNameValidate = false;

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

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

    confirmPasswordController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();

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
                            showCustomButtonSheet(context);
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
}

