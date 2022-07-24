import 'package:flutter/material.dart';
import 'package:naturalgas/homepage.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: Image.asset(
                  'assets/image/naturalgas.JPG',
                  height: 110,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'LOGIN TO CONTINUE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                  width: screenwidth,
                  child: TextFormField(
                    controller: namecontroller,
                    decoration: const InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person)),
                  )),
              Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20)),
                  height: 50,
                  width: screenwidth,
                  child: TextFormField(
                    controller: passcontroller,
                    decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock)),
                  )),
              InkWell(
                onTap: () {
                  if (namecontroller.text == "admin" &&
                      passcontroller.text == 'admin') {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return const Homepage();
                    }), (Route) => false).then(
                        (value) => namecontroller.clear());
                  } else {
                    SnackBar snackBar = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Not Match'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    namecontroller.clear();
                    passcontroller.clear();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 125, 94),
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: 150,
                  child: const Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Made by\n Wintech Service & Solution',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500))
            ],
          ),
        ),
      ),
    );
  }
}
