
import 'package:flutter/material.dart';
import 'package:skip_n_call/Model/CartListData.dart';
import 'package:skip_n_call/Pages/LeadDetailsList.dart';

class ZipDetails extends StatefulWidget {

  final Datum data;
  const ZipDetails({super.key, required this.data});

  @override
  State<ZipDetails> createState() => _ZipDetailsState();
}

class _ZipDetailsState extends State<ZipDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffFDF9FF),
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(
          color: Color(0Xff634099), // <-- SEE HERE
        ),
        centerTitle: true,
        title: const Text("Leads",
            style: TextStyle(
              color: Color(0Xff634099),
            )),
        backgroundColor: const Color(0XffFDF9FF),
      ),
      body: SafeArea(
          child: ListView(
            children: [
              
              Row(
                children: [

                  Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "#${widget.data.zipCode.toString()}",
                        style: const TextStyle(
                            fontSize: 30, color: Color(0Xff00A18A)),
                      )
                  ),
                ],
              ),
              
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LeadDetailsList(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Warm Lead',
                          style: TextStyle(
                              fontSize: 20, color: Color(0Xff634099)),
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 6.0),
                          child: const Text(
                            "20",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0Xff434141)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0),
                elevation: 5,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Home Owner Verified',
                        style: TextStyle(
                            fontSize: 20, color: Color(0Xff634099)),
                        textAlign: TextAlign.center,
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: const Text(
                          "10",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0Xff434141)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0),
                elevation: 5,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Raw Lead',
                        style: TextStyle(
                            fontSize: 20, color: Color(0Xff634099)),
                        textAlign: TextAlign.center,
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        child: const Text(
                          "5",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0Xff434141)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
