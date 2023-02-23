import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import '/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //initializing firebase dependency
  final Future<FirebaseApp> _initialization =Firebase.initializeApp();


  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text('could not connected'),
              );
            }
            if(snapshot.connectionState == ConnectionState.done){
              return MyLogin();
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      )
    );
  }
}