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
    "displaybran": "",
    "companyName": "",
    "companyAddress": "",
    "phoneNumber": ""
  };

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
  }

  getSharedPrefData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      data["displayPrice"] = prefs.getString("petrol") ?? '0';
      data["diedisplay"] = prefs.getString("die") ?? '0';
      data["displaypan"] = prefs.getString("Companypan") ?? '0';
      data["displaybran"] = prefs.getString("displaybran") ?? '';
      data["companyName"] = prefs.getString("companyName") ?? '';
      data["companyAddress"] = prefs.getString("companyAddress") ?? '';
      data["phoneNumber"] = prefs.getString("phoneNumber") ?? '';
    });
  }

  // double? price;

  void saveAndUpdateCompanyName() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("companyName", data['companyName']);

      data['companyName'] = prefs.getString('companyName') ?? '';
      print(prefs.getString("companyName"));

      setState(() {});

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdateCompanyAddress() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("companyAddress", data['companyAddress']);

      data['companyAddress'] = prefs.getString('companyAddress') ?? '';
      print(prefs.getString("companyAddress"));

      setState(() {});

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdatePhoneNumber() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("phoneNumber", data['phoneNumber']);

      data['phoneNumber'] = prefs.getString('phoneNumber') ?? '';
      print(prefs.getString("phoneNumber"));

      setState(() {});

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("petrol", data['price']);

      data['displayPrice'] = prefs.getString('petrol') ?? 0;

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

      data['diedisplay'] = prefs.getString('die') ?? 0;

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

      data['displaypan'] = prefs.getString('Companypan') ?? '0';

      setState(() {});

      print(prefs.getString("Companypan"));

      Navigator.of(context).pop();
    }
  }

  void saveAndUpdatebran() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("displaybran", data['displaybran']);

      data['displaybran'] = prefs.getString('displaybran') ?? '';
      print(prefs.getString("displaybran"));

      setState(() {});

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Company Name"),
            subtitle: Text(data['companyName']),
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
                                    data['companyName'] = value;
                                  },
                                  initialValue: data['companyName'],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdateCompanyName();
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
              icon: Icon(Icons.edit)
            )
          ),
          ListTile(
            title: Text("Company Address"),
            subtitle: Text(data['companyAddress']),
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
                                    data['companyAddress'] = value;
                                  },
                                  initialValue: data['companyAddress'],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdateCompanyAddress();
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
              icon: Icon(Icons.edit)
            )
          ),
          ListTile(
            title: Text("Phone Number"),
            subtitle: Text(data['phoneNumber']),
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
                                    data['phoneNumber'] = value;
                                  },
                                  initialValue: data['phoneNumber'],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdatePhoneNumber();
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
              icon: Icon(Icons.edit)
            )
          ),
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
                                  initialValue: data['price'],
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
                                  initialValue: data['die'],
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
                                  initialValue: data['Companypan'],
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
          ListTile(
            title: Text('Branch Number'),
            subtitle: Text(data['displaybran']),
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
                                    data['displaybran'] = value;
                                  },
                                  initialValue: data['displaybran'],
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      saveAndUpdatebran();
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
        ],
      ),
    );
  }
}
