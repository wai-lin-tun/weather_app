import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wather_app/home_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
   CheckUserConnection();
  }
 bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
           Timer(
        const Duration(seconds:1),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomeScreen())));
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
       setState(() {
          showMyDialog();
       });
      });
    }
  }
  showMyDialog ()async{
    return showDialog(
      context: context,
      barrierDismissible: false, 
    builder: (BuildContext context){
      return const AlertDialog(
        content: Text("No internet connection"),
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Daily",
                    style: TextStyle(
                        color: Color.fromARGB(255, 188, 187, 187),
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Weather",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

