import 'package:flutter/material.dart';

class drawerNavigation extends StatefulWidget {
  @override
  _drawerNavigationState createState() => _drawerNavigationState();
}

class _drawerNavigationState extends State<drawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children:<Widget> [
             UserAccountsDrawerHeader(
                 currentAccountPicture: CircleAvatar(
                   backgroundImage: NetworkImage(''),
                 ),
                 accountName: Text("Muhammed Ibrahim"),
                 accountEmail: Text("Mohamed77ebrahim@yahoo.com"),
             decoration: BoxDecoration(color: Colors.blue),
             )
          ],
        ),
      ),
    );
  }
}
