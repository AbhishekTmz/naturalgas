import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart' as intl;

class PostApi {
  static Future<int> post(
      {required String totalPrice,
      required double rate,
      required String title,
      required String quantity,
      required int billNumber}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var pannumber = prefs.getString("Companypan") ?? '';
    var branchnumber = prefs.getString("displaybran") ?? '';

    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://103.90.86.196:89/api/Mater'));
    var date = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
    var x = (0.13 * double.parse(totalPrice));
    var vat = double.parse(totalPrice) - x;
    request.body = json.encode(
        "Company_Pan:${pannumber},Branch_Code:$branchnumber,BillNo:${billNumber},Bill_dateTime:${date},Product:${title},Qty:${quantity},Rate:${rate},Amount:${vat},Discount:0,Vat:13,NetAmt:${totalPrice}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      prefs.setString('billNumber', '$billNumber');
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
