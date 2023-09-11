
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddFundDialog extends StatefulWidget {
  final String title, descriptions, text;
  Function(String) onClick;

  AddFundDialog(
      {super.key,
      required this.title,
      required this.descriptions,
      required this.text,
      required this.onClick});

  @override
  State<AddFundDialog> createState() => _AddFundDialogState();
}

class _AddFundDialogState extends State<AddFundDialog> {
  TextEditingController usernameController = TextEditingController();

  bool isLoading = false;
  bool isUserNameValidate = false;

  FocusNode usernameFocusNode = FocusNode();

  @override
  void dispose() {
    usernameFocusNode.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    if (usernameFocusNode.hasFocus) {
      usernameFocusNode.unfocus(); // Remove focus from the text field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 1), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, color: Color(0Xff634099)),
              ),
              const SizedBox(height: 35),
              SizedBox(
                height: 50,
                child: TextField(
                  focusNode: usernameFocusNode,
                  controller: usernameController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0Xff8F8F8F)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Enter Amount',
                    labelStyle:
                        (TextStyle(color: Color(0Xff8F8F8F), fontSize: 14)),
                    prefixIcon:
                        Icon(Icons.monetization_on, color: Color(0Xff8F8F8F)),
                    iconColor: Color(0Xff8F8F8F),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Color(0Xff634099)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (usernameController.text.toString().isEmpty) {
                        showSnackBar("Please enter the email or phone");
                        return;
                      }

                      Navigator.of(context).pop();
                      widget.onClick(usernameController.text.toString());
                    },
                    child: Text(
                      widget.text,
                      style: const TextStyle(fontSize: 14),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
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
          SnackbarController.closeCurrentSnackbar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
