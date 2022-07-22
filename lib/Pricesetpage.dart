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
    "branchno": "",
    "displaybranch": ""
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

  void saveAndUpdatebranch() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print("form is valid");
      print("branchno" + data['branchno']);

      //shared prefs
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("branchno", data['branchno']);

      data['displaybranch'] = prefs.getString('branchno')!;

      setState(() {});

      print(prefs.getString("branchno"));

      Navigator.of(context).pop();
    }
  }

  @override
  void didChangeDependencies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    data["displayPrice"] = prefs.getString("petrol");
    data["diedisplay"] = prefs.getString("die");
    data["displaypan"] = prefs.getString("Companypan");
    data["displaybranch"] = prefs.getString("branchno");
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
          ListTile(
            title: Text('Branch Number'),
            subtitle: Text(data['displaybranch']),
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
                                    data['branchno'] = value;
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
                                      saveAndUpdatebranch();
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
          )
        ],
      ),
    );
  }
}
