
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skip_n_call/Pages/ZipCart.dart';

import 'Dashboard.dart';
import 'EditProfile.dart';

class PurchaseZip extends StatefulWidget {
  const PurchaseZip({super.key});

  @override
  State<PurchaseZip> createState() => _PurchaseZipState();
}

class _PurchaseZipState extends State<PurchaseZip> {


  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          leading: const BackButton(
            color: Color(0Xff634099), // <-- SEE HERE
          ),
          centerTitle: true,
          title: const Text("My Zip",
              style: TextStyle(
                color: Color(0Xff634099),
              )),
          backgroundColor: const Color(0XffFDF9FF),

          actions: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ZipCart(),
                      ),
                    );

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 40, top: 10),
                    child: SvgPicture.asset(
                      height: 35,
                      width: 35,
                      'assets/images/ic_cart.svg',
                      color: const Color(0Xff634099),
                    ),
                  ),
                ),

                Card(
                    margin: const EdgeInsets.only(right: 40, top: 10),
                    color: const Color(0Xff00A18A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.5),
                    ),
                    child: const SizedBox(
                      height: 17,
                      width: 17,
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    )),
              ],
            ),
          ],

        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0XffFDF9FF),
          ),
          child: ListView(
            children: [

              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                             left: 15, right: 5,),
                        child: TextField(

                          cursorColor: const Color(0Xff634099),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                              const BorderSide(color: Colors.white, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 1.5, color: Color(0Xff634099)),
                            ),
                            hintText: 'Check Availability',
                            prefixIcon: const Icon(Icons.search,
                                size: 30.0, color: Color(0Xff634099)),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.clear,
                                size: 30.0,
                                color: Color(0Xff634099),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(Color(0Xff634099)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                              ),
                            ),

                          ),

                          onPressed: () {},
                          // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                          child: const Text('Search'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(5),
                            child: const Text(
                              'Expense',
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
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Country',
                          style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'State',
                            style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Place',
                            style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Longitude',
                            style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Latitude',
                            style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Status',
                            style: TextStyle(fontSize: 16, color: Color(0Xff434141)),
                          ),
                        ),

                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            ':',
                            style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              ':',
                              style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              ':',
                              style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              ':',
                              style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              ':',
                              style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              ':',
                              style: TextStyle(fontSize: 16, color: Color(0Xff00A18A)),
                            ),
                          ),

                        ],
                      )
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'United States',
                          style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'State',
                            style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Place',
                            style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Longitude',
                            style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Latitude',
                            style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Available',
                            style: TextStyle(fontSize: 16, color: Color(0Xff00A18A)),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 30,bottom: 50, right: 40, left: 40),
                height: 50,
                child: ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Color(0Xff00A18A)),

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                      ),
                    ),

                  ),

                  onPressed: () {},
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  child: const Text('Add To Cart'),
                ),
              ),


            ],
          ),
        ),

      ),
    );
  }
}
