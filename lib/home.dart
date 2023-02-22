import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
       centerTitle: true,
          title: Text('All Product List'),
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
