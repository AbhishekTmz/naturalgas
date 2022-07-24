import 'package:flutter/material.dart';
import 'package:naturalgas/Login/login.dart';
import 'package:naturalgas/Pricesetpage.dart';
import 'package:naturalgas/dieselcalcu.dart';
import 'package:naturalgas/fuelcalcu.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Home'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return const Priceset();
              }));
            },
            icon: const Icon(Icons.settings)),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return Login();
            })),
            child: Container(
              width: 110,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Text('LOGOUT'), Icon(Icons.logout)],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const DieselCalculations(
                        title: 'Diesel',
                      );
                    })),
                    child: SizedBox(
                      height: 200,
                      width: screenwidth / 2,
                      child: Column(children: [
                        Image.asset('assets/image/diesels.jpg', height: 150),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('FILL DIESEL',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Fuelcalcu(
                        title: "",
                      );
                    })),
                    child: SizedBox(
                      height: 200,
                      width: screenwidth / 2,
                      child: Column(children: [
                        Image.asset('assets/image/fuel.jpg', height: 150),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('FILL PETROL',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                      ]),
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 30),
              //       height: 150,
              //       width: 180,
              //       child: Column(children: const [
              //         Text('TOTAL\n DIESEL FILLED ',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w400,
              //             )),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Text('Rs . 10,000 ',
              //             style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400,
              //                 color: Colors.orangeAccent))
              //       ]),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 30),
              //       height: 150,
              //       width: 180,
              //       child: Column(children: const [
              //         Text('TOTAL\n FUEL FILLED ',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w400,
              //             )),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Text('Rs . 10,000 ',
              //             style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.w400,
              //                 color: Colors.orangeAccent))
              //       ]),
              //     ),
              //   ],
              // ),
              // Container(
              //   child: Column(
              //     children: [
              //       CircleAvatar(
              //         backgroundColor: Colors.white,
              //         radius: 90,
              //         child: Image.asset(
              //           'assets/image/cash.jpg',
              //           height: 130,
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 15,
              //       ),
              //       const Text(
              //         'TOTAL AMOUNT',
              //         style:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              //       ),
              //       const SizedBox(
              //         height: 5,
              //       ),
              //       const Text(
              //         'RS . 20,000',
              //         style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w400,
              //             color: Colors.orangeAccent),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
