import 'package:flutter/material.dart';
import 'drawer.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  MainDrawer(),
    appBar: AppBar(
      backgroundColor: Colors.brown,
       centerTitle: true,
          title: Text('Home'),
           actions: [
         IconButton(
            onPressed: () {

           },
            icon: Icon(Icons.add))
  ],
  ),


  );

  }
}
