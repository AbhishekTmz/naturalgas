import 'package:flutter/material.dart';
import 'package:naturalgas/bill.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DieselCalculations extends StatefulWidget {
  const DieselCalculations({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DieselCalculations> createState() => _DieselCalculationsState();
}

class _DieselCalculationsState extends State<DieselCalculations> {
  int? firstnum;
  int? secondnum;
  double? ptrprice;
  String dropdownvalue = 'Liter';
  String? userInput;
  String? result;
  int dotCount = 0;
  // List of items in our dropdown menu
  var items = [
    'Liter',
    'Price',
  ];

  clearField() {
    setState(() {
      firstnum = 0;
      secondnum = 0;
      userInput = '';
      result = '';
      dotCount = 0;
    });
  }

  void btnclicked(String btnvalue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var diePrice = prefs.getString("die") ?? '0';
    ptrprice = double.parse(diePrice);

    if (btnvalue == 'C') {
      clearField();
    } else {
      setState(() {
        if (btnvalue == '.') {
          dotCount++;
        }
        if (btnvalue == '.' && dotCount > 1) {
        } else {
          userInput = (userInput ?? '') + btnvalue;
          if (userInput == "") {
            result = '';
          } else {
            result = dropdownvalue == items[0]
                ? (double.parse(userInput ?? '0') * double.parse(diePrice))
                    .toStringAsFixed(2)
                : (double.parse(userInput ?? '0') / double.parse(diePrice))
                    .toStringAsFixed(2);
          }
        }
      });
    }
  }

  Widget custombutton(String btnvalue) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.only(bottom: 10),
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
          actions: [
            DropdownButton(
              value: dropdownvalue,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              dropdownColor: Colors.teal,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                clearField();
              },
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: ListView(children: [
          Container(
            padding: const EdgeInsets.only(top: 60),
            margin: const EdgeInsets.only(top: 10, right: 5),
            height: 80,
            width: 320,
            child: Text(
              dropdownvalue == items[0]
                  ? '${(userInput ?? '')} Ltr'
                  : 'Rs.${(userInput ?? '')} ',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 20,
          ),
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
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.grey.shade200),
            height: 60,
            width: 300,
            child: Text(
              dropdownvalue == items[0]
                  ? 'Rs. ${(result ?? '')}'
                  : '${(result ?? '')} Ltr',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                          Text(
                              'Total Quantity - ${dropdownvalue == items[0] ? (userInput ?? '') : (result ?? '')} Ltr'),
                          Text(
                              'Amount - Rs. ${dropdownvalue == items[0] ? (result ?? '') : (userInput ?? '')}'),
                          Text('----------------------------------'),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Do you really want to proceed?',
                            style: TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                          Text('----------------------------------'),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.teal),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Bill(
                                            quantity: dropdownvalue == items[0]
                                                ? (userInput ?? '')
                                                : (result ?? ''),
                                            totalPrice:
                                                dropdownvalue == items[0]
                                                    ? (result ?? '')
                                                    : (userInput ?? ''),
                                            rate: ptrprice!,
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
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.teal),
              child: const Text(
                'Print',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
