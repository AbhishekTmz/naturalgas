import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Priceset extends StatefulWidget {
  const Priceset({Key? key}) : super(key: key);

  @override
  State<Priceset> createState() => _PricesetState();
}

class _PricesetState extends State<Priceset> {
  // final priceController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Map data = {
    "price": "",
    "displayPrice": "",
    "die": "",
    "diedisplay": "",
    "Companypan": "",
    "displaypan": "",
    // "branch": "",
    // "displaybran": ""
  };

  // double? price;

  void saveAndUpdate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("form is valid");
      print("petrol" + data['price']);

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("petrol", data['price']);

      data['displayPrice'] = prefs.getString('petrol')!;

      setState(() {});

      print(prefs.getString("petrol"));

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdatedie() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("form is valid");
      print("die" + data['die']);

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("die", data['die']);

      data['diedisplay'] = prefs.getString('die')!;

      setState(() {});

      print(prefs.getString("die"));

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdatepan() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("form is valid");
      print("Companypan" + data['Companypan']);

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("Companypan", data['Companypan']);

      data['displaypan'] = prefs.getString('Companypan')!;

      setState(() {});

      print(prefs.getString("Companypan"));

      Navigator.of(context).pop();
    }
  }

  // void saveAndUpdatebran() async {
  //   if (formKey.currentState!.validate()) {
  //     formKey.currentState!.save();
  //     print("form is valid");
  //     print("branch" + data['branch']);

  //     //shared prefs
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();

  //     await prefs.setString("branch", data['branch']);

  //     data['displaybran'] = prefs.getString('branch')!;

  //     setState(() {});

  //     print(prefs.getString("branch"));

  //     Navigator.of(context).pop();
  //   }
  // }

  @override
  void didChangeDependencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    data["displayPrice"] = prefs.getString("petrol");
    data["diedisplay"] = prefs.getString("die");
    data["displaypan"] = prefs.getString("Companypan");
    data["displaybran"] = prefs.getString("branch");

    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Petrol Price"),
            subtitle: Text(data['displayPrice']),
            trailing: IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 500,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (value) {
                                    data['price'] = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdate();
                                    });
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                icon: Icon(Icons.edit)),
          ),
          ListTile(
            title: Text("Diesel Price"),
            subtitle: Text(data['diedisplay']),
            trailing: IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 500,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (value) {
                                    data['die'] = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdatedie();
                                    });
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                icon: Icon(Icons.edit)),
          ),
          ListTile(
            title: Text('Company pan'),
            subtitle: Text(data['displaypan']),
            trailing: IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 500,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  onSaved: (value) {
                                    data['Companypan'] = value;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdatepan();
                                    });
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                icon: Icon(Icons.edit)),
          ),
          // ListTile(
          //   title: Text('Company pan'),
          //   subtitle: Text(data['displaybran']),
          //   trailing: IconButton(
          //       onPressed: () => showModalBottomSheet(
          //           context: context,
          //           builder: (context) {
          //             return Container(
          //               height: 500,
          //               child: Padding(
          //                 padding: EdgeInsets.all(20),
          //                 child: Form(
          //                   key: formKey,
          //                   child: Column(
          //                     children: [
          //                       TextFormField(
          //                         onSaved: (value) {
          //                           data['branch'] = value;
          //                         },
          //                         decoration: InputDecoration(
          //                             border: OutlineInputBorder()),
          //                       ),
          //                       SizedBox(
          //                         height: 10,
          //                       ),
          //                       ElevatedButton(
          //                         onPressed: () async {
          //                           setState(() {
          //                             saveAndUpdatebran();
          //                           });
          //                         },
          //                         child: Text("Update"),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           }),
          //       icon: Icon(Icons.edit)),
          // ),
        ],
      ),
    );
  }
}
