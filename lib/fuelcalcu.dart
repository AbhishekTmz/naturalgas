import 'package:flutter/material.dart';
import 'package:naturalgas/bill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fuelcalcu extends StatefulWidget {
  const Fuelcalcu({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Fuelcalcu> createState() => _FuelcalcusState();
}

class _FuelcalcusState extends State<Fuelcalcu> {
  int? firstnum;
  int? secondnum;
  String texttodisplay = "";
  String? res;
  String littodisplay = "";
  double ptrprice = 181;

  void btnclicked(String btnvalue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var petrolPrice = prefs.getString("petrol") ?? '0';

    setState(() {
      if (btnvalue == 'C') {
        texttodisplay = "";
        littodisplay = "";
        firstnum = 0;
        secondnum = 0;
        res = "";
      } else {
        res = int.parse(texttodisplay + btnvalue).toString();
        texttodisplay = res.toString();
        if (texttodisplay == "") {
          littodisplay = '';
        } else {
          littodisplay =
              (double.parse(texttodisplay) * double.parse(petrolPrice))
                  .toStringAsFixed(2);
        }
      }
    });
  }

  Widget custombutton(String btnvalue) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(5),
      height: 70,
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal)),
        onPressed: () => btnclicked(btnvalue),
        child: Text(
          btnvalue,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              margin: const EdgeInsets.only(top: 10),
              height: 80,
              width: 320,
              child: Text(
                'Rs.$littodisplay ',
                textAlign: TextAlign.right,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(children: [
                    custombutton('9'),
                    custombutton('8'),
                    custombutton('7'),
                  ]),
                  Row(children: [
                    custombutton('6'),
                    custombutton('5'),
                    custombutton('4'),
                  ]),
                  Row(children: [
                    custombutton('3'),
                    custombutton('2'),
                    custombutton('1'),
                  ]),
                  Row(children: [
                    custombutton('C'),
                    custombutton('0'),
                    custombutton('.'),
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              height: 60,
              width: 300,
              child: Text(
                '$texttodisplay ltr',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Column(
                          children: [
                            Text('Total Quantity - $texttodisplay Ltr'),
                            Text('Amount - $littodisplay'),
                            Text('----------------------------------'),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Do you really want to proceed?',
                              textAlign: TextAlign.center,
                            ),
                            Text('----------------------------------'),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.shade500),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.teal),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Bill(
                                              quantity: texttodisplay,
                                              totalPrice: littodisplay,
                                              rate: ptrprice,
                                              title: widget.title,
                                            );
                                          }));
                                        },
                                        child: const Text(
                                          'Print',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ])
                          ],
                        ),
                      )),
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal),
                height: 40,
                width: 100,
                child: const Text(
                  'Print',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
