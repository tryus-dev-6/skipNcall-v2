import 'package:flutter/material.dart';

class PayableLead extends StatefulWidget {
  const PayableLead({super.key});

  @override
  State<PayableLead> createState() => _PayableLeadState();
}

class _PayableLeadState extends State<PayableLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Container(
            color: const Color(0XffFDF9FF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  elevation: 5,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text(
                          "Warm Lead",
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              fontSize: 16, color: Color(0Xff00A18A)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            "Unpaid Lead - 10",
                            style: TextStyle(
                                fontSize: 15, color: Color(0Xff5A5A5A)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: const Text(
                            "Total Payable - \$500",
                            style: TextStyle(
                                fontSize: 15, color: Color(0Xff5A5A5A)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
