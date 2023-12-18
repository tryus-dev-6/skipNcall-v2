
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skip_n_call/Model/Place.dart';
import 'package:skip_n_call/Pages/ZipCart.dart';

import '../Api/base_client.dart';
import '../Helper/SharedPreferencesHelper.dart';
import '../Helper/dialog_helper.dart';
import '../Model/CommonResponse.dart';
import '../Util/ColorCodes.dart';
import '../Util/Constants.dart';
import '../Util/Tools.dart';
import 'Dashboard.dart';
import 'Login.dart';

class PurchaseZip extends StatefulWidget {
  const PurchaseZip({super.key});

  @override
  State<PurchaseZip> createState() => _PurchaseZipState();
}

class _PurchaseZipState extends State<PurchaseZip> {

  bool buttonEnable = false;


  SampleItem? selectedMenu;
  TextEditingController zipSearchController = TextEditingController();
  String country = '';
  String state = '';
  String place = '';
  String longitude = '';
  String latitude = '';
  String status = '';
  String searchedZip = '';
  String cartCount = '0';
  String currentPackage = '';
  BuildContext? mContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateCartCount();
  }

  @override
  Widget build(BuildContext context) {

    mContext = context;

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
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: color0,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: color0),

          actions: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                GestureDetector(
                  onTap: (){

                    Get.toNamed("/zipCart");

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 40, top: 10),
                    height: 35,
                    width: 35,
                    child: SvgPicture.asset(
                      height: 25,
                      width: 25,
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
                    child: SizedBox(
                      height: 17,
                      width: 17,
                      child: Center(
                        child: Text(
                          cartCount,
                          style: const TextStyle(fontSize: 12, color: Colors.white),
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

                          controller: zipSearchController,
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
                              onPressed: () {
                                zipSearchController.clear();
                              },
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

                          onPressed: () {
                            DialogHelper.showLoading();
                            zipSearch();
                          },
                          // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                          child: const Text('Search'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 30, left: 20),
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
                              style: TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),

                        ],
                      )
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country,
                            style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              state,
                              style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              place,
                              style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              longitude,
                              style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              latitude,
                              style: const TextStyle(fontSize: 16, color: Color(0Xff696969)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 20),
                            child: Text(
                              status,
                              softWrap: true,
                              style: status == "Available." ? const TextStyle(fontSize: 16, color: Color(0Xff00A18A)) : const TextStyle(fontSize: 16, color: Colors.red),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 30,bottom: 50, right: 40, left: 40),
                height: 45,
                child: buttonEnable? ElevatedButton(

                  //onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Color(0Xff00A18A)),

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                      ),
                    ),

                  ),

                  onPressed: () {
                    addToCart();
                  },

                  child: const Text(
                    'Add To Cart',
                    // style: TextStyle(color: Colors.white),
                  ),
                ): ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Color(0Xff88bdb5)),

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),

                  ),

                  onPressed: null,
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }

  Future<void> initiateCartCount() async {
    //DialogHelper.showLoading();

    String? userId =
    await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    var response;

    var profile = {"client_id": userId};

    response = await BaseClient()
        .postWithToken('client/zip/cart/count', profile)
        .catchError((err) {
      debugPrint('error: $err');
    });

    if (response == null) {
      Tools.flushBarErrorMessage('failed to get response', mContext!);
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      if(allDatum.totalZip != null){
        cartCount = allDatum.totalZip!.toString();
      }

      setState(() {

      });

    } else {
      if (allDatum.message != null) {
        Tools.flushBarErrorMessage(allDatum.message.toString(), mContext!);
      }
      if(allDatum.isTokenValid == false){
        toLogInPage();
      }
    }

    //DialogHelper.hideDialog();
  }

  Future<void> toLogInPage() async {

    String email = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_EMAIL);
    String password = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_PASSWORD);
    SharedPreferencesHelper.clearAllData();
    SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_EMAIL, email);
    SharedPreferencesHelper.saveData(SKIP_N_CALL_USER_PASSWORD, password);
    Get.offAllNamed('/login');

  }

  Future<void> zipSearch() async {

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    String zip = zipSearchController.text.toString();

    if (zip.isEmpty) {
      Tools.flushBarErrorMessage("Please enter a zip number", mContext!);
      DialogHelper.hideDialog();
      return;
    }

    var response;

    var search = {
      "code": zip,
      "client_id": userId
    };

    response = await BaseClient()
        .postWithToken('client/zip/search', search)
        .catchError((err) {
      debugPrint('error: $err');
    });


    if (response == null) {
      Tools.flushBarErrorMessage('failed to get response', mContext!);
      DialogHelper.hideDialog();
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {
      List<Place>? listData = allDatum.data?.places;
      country = allDatum.data!.country!;
      status = allDatum.message!;
      setState(() {

        currentPackage = allDatum.purchasedPackage.toString();
        searchedZip = zip;

        if(listData!=null && listData.isNotEmpty) {
          state = listData[0].state!;
          place = listData[0].placeName!;
          longitude = listData[0].longitude!;
          latitude = listData[0].latitude!;
        }

        if(status == "Available.") {
          buttonEnable = true;
        }
        else{
          buttonEnable = false;
        }

      });
    }
    else{
      setState(() {
        buttonEnable = false;
        status = allDatum.message!;
        country = '';
        state = '';
        place = '';
        longitude = '';
        latitude = '';
      });
    }

    DialogHelper.hideDialog();

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

  Future<void> addToCart() async {
    DialogHelper.showLoading();

    String? userId = await SharedPreferencesHelper.getData(SKIP_N_CALL_USER_USERID);

    if(currentPackage.isEmpty) {

      Tools.flushBarErrorMessage("Please Purchase a Package First", mContext!);

      DialogHelper.hideDialog();

      return;
    }

    debugPrint('packageId: $currentPackage');

    var response;

    var add = {
      "client_id": userId,
      "code": searchedZip,
      "package_id": currentPackage,
    };

    response = await BaseClient()
        .postWithToken('client/zip/cart', add)
        .catchError((err) {
      debugPrint('error: $err');
    });

    DialogHelper.hideDialog();

    if (response == null) {
      Tools.flushBarErrorMessage('failed to get response', mContext!);
      return;
    }
    var res = json.decode(response);
    debugPrint('successful: $res');

    CommonResponse allDatum = allDataFromJson(response);

    if (allDatum.status == true) {

      if(allDatum.message != null) {
        Tools.flushBarSuccessMessage(allDatum.message.toString(), mContext!);
        //cartCount = allDatum.cartCount.toString();
        initiateCartCount();
      }

      setState(() {
        buttonEnable = false;
      });
    }
    else{
      if(allDatum.message != null) {
        Tools.flushBarErrorMessage(allDatum.message.toString(), mContext!);
      }
    }

    DialogHelper.hideDialog();
  }
}
