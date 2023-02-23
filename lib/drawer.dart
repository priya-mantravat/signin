import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Drawer(
  // backgroundColor: Colors.black,
  child: Column(
  children: [
  Container(
  width: double.infinity,
  color: Colors.brown,
  padding: const EdgeInsets.all(20),
  child: Center(
  child: Column(
  children: [
  Container(
  margin: const EdgeInsets.fromLTRB(0,50,0,15),
  width: 100,
  height: 100,
  // margin: EdgeInsets.only( top:30 ),
  // decoration: BoxDecoration(
  //   shape: BoxShape.circle,
  //   image: DecorationImage(
  //       image: AssetImage(
  //           'assets/draw.jpg'),
  //     fit: BoxFit.fill),
  // ),
  child: const CircleAvatar(
  backgroundImage: AssetImage('assets/jenny.jpg'),
  radius: 50,

  ),
  ),
  const Text('Jenny Singh',
  style:TextStyle(fontSize: 22 , color: Colors.white,),),
  const Text('jenny@gmail.com',
  style:TextStyle(fontSize: 15 , color: Colors.white,),),
  ],
  ),
  ),
  ),
  const ListTile(
  leading: Icon(Icons.person),
  title: Text('Profile',
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  ),),
  onTap:null ,
  ),
  const ListTile(
  leading: Icon(Icons.settings),
  title: Text('Settings',
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),),
    onTap:null ,
    ),
    const ListTile(
    leading: Icon(Icons.arrow_back ),
    title: Text('Logout',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    ),),
    onTap:null ,
    ),
    ],
    ),
    );
  }
}
