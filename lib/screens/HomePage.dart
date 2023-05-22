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
      body: ListView(children: const [
        SizedBox(
          height: 20,
        ),
        SingleChoice(),
      ]),
    );
  }
}

enum _SelectedTab { Activas, Historial }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});
  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  _SelectedTab dateView = _SelectedTab.Activas;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 340,
          child: SegmentedButton<_SelectedTab>(
            segments: const <ButtonSegment<_SelectedTab>>[
              ButtonSegment<_SelectedTab>(
                value: _SelectedTab.Activas,
                label: Text('Activas'),
                icon: Icon(Icons.local_activity_rounded),
              ),
              ButtonSegment<_SelectedTab>(
                value: _SelectedTab.Historial,
                label: Text('Historial'),
                icon: Icon(Icons.history_rounded),
              ),
            ],
            selected: <_SelectedTab>{dateView},
            onSelectionChanged: (Set<_SelectedTab> newSelection) {
              setState(() {
                dateView = newSelection.first;
              });
            },
          ),
        ),
        const SizedBox(height: 30),
        IndexedStack(
          index: dateView == _SelectedTab.Activas ? 0 : 1,
          children: [
            Center(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.album),
                      title:
                          Text('"Nombre del Paciente            "' + 'Fecha'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('BUY TICKETS'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('LISTEN'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Contenido para la opción Historial
            const Center(
                child: Text(
              'Contenido para la opción Historial',
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ],
    );
  }
}
