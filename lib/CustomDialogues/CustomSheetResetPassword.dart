
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void showCustomButtonSheet(BuildContext context){
//
//   showModalBottomSheet<void>(
//     context: context,
//     backgroundColor: Colors.transparent,
//     builder: (BuildContext context) {
//       return Container(
//
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//         ),
//         //height: 200,
//         child: ListView(
//           shrinkWrap: true,
//           children: <Widget>[
//             GestureDetector(
//               onTap: (){
//                 Navigator.pop(context);
//               },
//               child: Container(
//                 padding: const EdgeInsets.only(right: 18, top: 15),
//                 alignment: Alignment.topRight,
//                   child: const Icon(
//                       Icons.close, color: Color(0Xff8F8F8F)
//                   )
//               ),
//             ),
//
//             Container(
//               margin: const EdgeInsets.only(right: 20, left: 20),
//               child: Column(
//                 children: [
//                   Container(
//                     alignment: Alignment.topLeft,
//                     child: const Text(
//                       'Email Verification',
//                       style: TextStyle(fontSize: 25, color: Color(0Xff383737)),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.topLeft,
//                     margin: const EdgeInsets.only(top: 10),
//                     child: const Text(
//                       'Please enter the 6 digit code from your submitted email',
//                       style: TextStyle(fontSize: 14, color: Color(0Xff383737)),
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//                   const TextField(
//                     // focusNode: passwordFocusNode,
//                     // controller: passwordController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0Xff8F8F8F)),
//                           borderRadius:
//                           BorderRadius.all(Radius.circular(10))),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0Xff8F8F8F)),
//                           borderRadius:
//                           BorderRadius.all(Radius.circular(10))),
//                       labelText: 'Enter code',
//                       labelStyle: (TextStyle(
//                           color: Color(0Xff8F8F8F), fontSize: 14)),
//                       prefixIcon: Icon(Icons.code_rounded),
//                       iconColor: Color(0Xff8F8F8F),
//                     ),
//                     keyboardType: TextInputType.visiblePassword,
//                     textInputAction: TextInputAction.done,
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//
//                       style: ButtonStyle(
//                         backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),
//
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
//                           ),
//                         ),
//
//                       ),
//
//                       child: const Text(
//                         'Submit',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       onPressed: () {
//
//                       },
//                     ),
//                   ),
//
//                   const SizedBox(height: 50),
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }