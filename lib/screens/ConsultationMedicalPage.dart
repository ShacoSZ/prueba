import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  createState() => _favoritepageState();
}

class _favoritepageState extends State<FavoritePage> {
  var prdcts = ['La blanquita', 'Pizza Hut', 'Little Caesars'];
  @override
  Widget build(BuildContext context) {
    //final userState = context.watch<UserState>();
    //final user = userState.user;

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido ${user?.displayName}'),
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
            Text(
              'Aqui iria la lista de consultas medicas',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}
