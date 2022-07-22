// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class bill extends StatelessWidget {
//   const bill({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 400,
//               child: Text(
//                 'BARAL OIL DISTRIBUTORS P .LTD \n  POKHARA - 7 \n PAN : 300225572 \n PH : 061-528245 \n Tax Invoice',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             Text(
//               'Bill no : VAT, \n Date : 2079/1/4 \n Mode : Cash',
//               textAlign: TextAlign.left,
//             ),
//             Text(
//               '----------------------------------------',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('Item'),
//                 Text('Qty'),
//                 Text('Rate'),
//                 Text('Amount')
//               ],
//             ),
//             Text(
//               '----------------------------------------',
//               style: TextStyle(fontSize: 20),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('Petrol'),
//                 Text('2.73'),
//                 Text('181'),
//                 Text('2000')
//               ],
//             ),
//             Container(child: Column(
//               children: [
//                 Text('TAXABLE')
//               ],
//             ),)
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

class Bill extends StatefulWidget {
  const Bill(
      {Key? key,
      required this.quantity,
      required this.totalPrice,
      required this.rate,
      required this.title})
      : super(key: key);
  final String totalPrice;
  final String quantity;
  final double rate;
  final String title;
  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  @override
  void initState() {
    super.initState();
    postApi();
  }

  postApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var pannumber = prefs.getString("Companypan") ?? '';
    var branchnumber = prefs.getString("displaybran") ?? '';
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://103.90.86.196:89/api/Mater'));
    var date = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    var x = (0.247 * double.parse(widget.totalPrice));
    var vat = double.parse(widget.totalPrice) + x;
    request.body = json.encode(
        "Company_Pan:$pannumber,Branch_Code:$branchnumber,BillNo:S0-00003,Bill_dateTime:$date,Product:MS-PETROL,Qty:${widget.quantity},Rate:${widget.rate},Amount:${widget.totalPrice},Discount:0,Vat:24.7,NetAmt:$vat");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  final pdf = pw.Document();

  pdfCreation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var x = (0.247 * double.parse(widget.totalPrice));
    var vat = double.parse(widget.totalPrice) + x;
    var pannumber = prefs.getString("Companypan") ?? '';
    var branchnumber = prefs.getString("displaybran") ?? '';
    var date = intl.DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    // Directory tempdir = await getTemporaryDirectory();
    // String temppath = tempdir.path;
    pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            width: 200,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 400,
                    child: pw.Text(
                      'BARAL OIL DISTRIBUTORS P .LTD \n  POKHARA - 7 \n PAN : ${pannumber} \n PH : 061-528245 \n Tax Invoice \n Branch : ${branchnumber}',
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.Text(
                    'Bill no : VAT, \n Date : 2079/1/4 \n Mode : Cash',
                    textAlign: pw.TextAlign.left,
                  ),
                  pw.Text(
                    '------------------------------',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('Item'),
                      pw.Text('Qty'),
                      pw.Text('Rate'),
                      pw.Text('Amount')
                    ],
                  ),
                  pw.Text(
                    '------------------------------',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text(widget.title),
                      pw.Text(widget.quantity),
                      pw.Text(widget.rate.toString()),
                      pw.Text(widget.totalPrice),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                  pw.Container(
                    padding: const pw.EdgeInsets.only(left: 100),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('TAXABLE'),
                        pw.Text('Vat(24.7%): $x '),
                        pw.Text('Grand Total : ${vat}'),
                        pw.Text('Chnage : 0.00')
                      ],
                    ),
                  ),
                  pw.Text(
                    '------------------------------',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.Text('** NOTE'),
                  // pw.Text('User : 101'),
                  pw.Text('Print time : $date'),
                  pw.SizedBox(height: 10),
                  pw.Text('Visit Again , Thank You ')
                ]),
          );
        },
        pageFormat: PdfPageFormat.a4));
    // final output = await getTemporaryDirectory();
    final file = File("bill.pdf");

    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    pdfCreation();
    return Scaffold(
      body: Center(child: PdfPreview(build: (format) => pdf.save())),
    );
  }
}
