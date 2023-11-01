
import 'package:flutter/material.dart';

class DeactivateAccountDialog extends StatefulWidget {
  const DeactivateAccountDialog({super.key});

  @override
  State<DeactivateAccountDialog> createState() => _DeactivateAccountDialogState();
}

class _DeactivateAccountDialogState extends State<DeactivateAccountDialog> {

  TextEditingController deactivatePasswordController = TextEditingController();
  TextEditingController deactivateTextController = TextEditingController();


  FocusNode currentPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode deactivatePasswordFocusNode = FocusNode();
  FocusNode deactivateTextFocusNode = FocusNode();

  bool isPasswordVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPasswordVisible = true;
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
                    'Account Deactivate',
                    style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Please enter cause of deactivation',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  focusNode: deactivateTextFocusNode,
                  controller: deactivateTextController,

                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    labelText: 'Type your deactivation cause',
                    alignLabelWithHint: true,
                    labelStyle: (TextStyle(
                        color: Color(0Xff8F8F8F), fontSize: 14)),
                    iconColor: Color(0Xff8F8F8F),

                  ),
                  //keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  //textInputAction: TextInputAction.done,
                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Please enter your password',
                    style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
                  ),
                ),

                const SizedBox(height: 10),
                TextField(
                  obscureText: isPasswordVisible,
                  focusNode: deactivatePasswordFocusNode,
                  controller: deactivatePasswordController,
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
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
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
}
