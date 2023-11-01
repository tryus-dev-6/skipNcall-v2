import 'package:flutter/material.dart';

import '../Util/Tools.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

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

  void updatePassword(BuildContext context) {

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

  }
}
