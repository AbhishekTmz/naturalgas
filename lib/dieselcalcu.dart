import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:naturalgas/post_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunmi_printer_plus/column_maker.dart';
import 'package:sunmi_printer_plus/enums.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:sunmi_printer_plus/sunmi_style.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class DieselCalculations extends StatefulWidget {
  const DieselCalculations({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<DieselCalculations> createState() => _DieselCalculationsState();
}

class _DieselCalculationsState extends State<DieselCalculations> {
  TextEditingController _tenderAmt = TextEditingController(text: '0');

  TextEditingController _vehicleNo = TextEditingController(text: '000000');

  int? firstnum;
  int? secondnum;
  double? ptrprice;
  String dropdownvalue = 'Liter';
  String? userInput;
  String? result;
  int dotCount = 0;
  int billNumber = Random().nextInt(1000);
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

  Future<bool?> _bindingPrinter() async {
    await SunmiPrinter.initPrinter();
    final bool? result = await SunmiPrinter.bindingPrinter();

    return result;
  }

  final url = "http://103.90.86.196:89/api/Mater/123456789";
  int dbBillNo = 1;

  void fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));
      final data = await response.body;
      final char = data.split('"');

      setState(() {
        dbBillNo = int.parse(char[1]);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void printBill(
      {required String totalPrice,
      required double rate,
      required String title,
      required String quantity}) async {
    await _bindingPrinter();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    billNumber = Random().nextInt(10000);

    var x = (0.13 * double.parse(totalPrice));
    var tender = double.parse(_tenderAmt.text);
    if (tender == '') {
      tender = 0;
    }
    var vehicleNo = _tenderAmt.text;
    if (vehicleNo == '') {
      vehicleNo = '000000';
    }
    var change = double.parse(totalPrice) - tender;
    var vat = double.parse(totalPrice) - x;
    var pannumber = prefs.getString("Companypan") ?? '';
    var companyName = prefs.getString("companyName") ?? '';
    var companyAddress = prefs.getString("companyAddress") ?? '';
    var phoneNumber = prefs.getString("phoneNumber") ?? '';
    var branchnumber = prefs.getString("displaybran") ?? '';
    var random = Random().nextInt(1000000);

    var date = intl.DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printText(companyName,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText(companyAddress,
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('PAN: $pannumber',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('PH: $phoneNumber',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('Tax Invoice',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('Branch: $branchnumber',
        style: SunmiStyle(
            align: SunmiPrintAlign.CENTER,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('Bill No: BA-${dbBillNo + 1}',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.printText('Mode: CASH',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.MD,
            bold: true));
    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(
        text: 'Item',
        width: 8,
      ),
      ColumnMaker(text: 'Qty', width: 8),
      ColumnMaker(text: 'Rate', width: 8),
      ColumnMaker(text: 'Amount', width: 8),
    ]);

    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: title, width: 8),
      ColumnMaker(text: '${quantity}L', width: 8),
      ColumnMaker(text: '${rate}/L', width: 8),
      ColumnMaker(text: x.toStringAsFixed(2), width: 8),
    ]);
    // await SunmiPrinter.printText('TAXABLE',
    //     style: SunmiStyle(
    //       align: SunmiPrintAlign.RIGHT,
    //     ));
    await SunmiPrinter.printText('Taxable Amt: Rs. $vat',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.printText('VAT(13%): Rs. $x',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.printText('Total: Rs.${totalPrice}',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.printText('Tender: Rs.${tender}',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.printText('Change: Rs.${change}',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.printText('Vehicle No: ${vehicleNo}',
        style: SunmiStyle(
          align: SunmiPrintAlign.RIGHT,
        ));
    await SunmiPrinter.line();
    await SunmiPrinter.printText('**NOTE',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.SM,
            bold: true));
    await SunmiPrinter.printText('Print time : $date',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.SM,
            bold: true));
    await SunmiPrinter.lineWrap(2);
    await SunmiPrinter.printText('Visit Again , Thank You ',
        style: SunmiStyle(
            align: SunmiPrintAlign.LEFT,
            fontSize: SunmiFontSize.SM,
            bold: true));
    await SunmiPrinter.lineWrap(4);
    await SunmiPrinter.exitTransactionPrint(true);
    await PostApi.post(
            billNumber: dbBillNo + 1,
            totalPrice: totalPrice,
            rate: rate,
            title: title,
            quantity: quantity)
        .then((value) => Navigator.pop(context));
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
          title: Text('${widget.title}'),
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
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: 150,
              child: TextFormField(
                controller: _tenderAmt,
                decoration: const InputDecoration(
                    hintText: 'Tender Amount',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.attach_money_rounded)),
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: 150,
              child: TextFormField(
                controller: _vehicleNo,
                decoration: const InputDecoration(
                    hintText: 'Vehicle Number',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.car_repair_outlined)),
              )),
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
                                        printBill(
                                          quantity: dropdownvalue == items[0]
                                              ? (userInput ?? '')
                                              : (result ?? ''),
                                          totalPrice: dropdownvalue == items[0]
                                              ? (result ?? '')
                                              : (userInput ?? ''),
                                          rate: ptrprice!,
                                          title: 'Diesel',
                                        );
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
