import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  createState() => _homepageState();
}

class _homepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //final userState = context.watch<UserState>();
    //final user = userState.user;
    //var nombre = user?.displayName;

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido ${user?.displayName} '),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: Text(
                'Bienvenido a Raccoon Doctor',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                '${user?.displayName}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                '${user?.email}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                '${user?.getIdToken()}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                '${user?.providerData}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ));
  }
}
