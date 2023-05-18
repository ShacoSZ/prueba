import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';
import 'package:intl/intl.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class consultM {
  String user = '';
  String date = '';
  bool online = false;
  String sickness = '';
  String description = '';
  bool anotherPerson = false;
}

var consulta = consultM();

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  createState() => _favoritepageState();
}

class _favoritepageState extends State<FavoritePage> {
  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dateController.text = '';
  }

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
        body: Container(
            color: const Color(0xFFEDF2F5),
            child: Center(
                child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: ListView(
                      children: [
                        Text(
                          'Necesitas Atencion Medica?, llena este formulario y te contactaremos',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Enfermedad o Sintoma',
                            labelStyle:
                                TextStyle(color: const Color(0xFF19969E)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu nombre';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            consulta.sickness = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Descripcion',
                            labelStyle:
                                TextStyle(color: const Color(0xFF19969E)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, ingresa tu apellido';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            consulta.description = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: 'Fecha y Hora',
                            labelStyle:
                                TextStyle(color: const Color(0xFF19969E)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2023), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              if (pickedDate != null) {
                                print(
                                    pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                String formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(
                                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                print(
                                    formattedDate); //formatted date output using intl package =>  2022-07-04
                                //You can format date as per your need

                                setState(() {
                                  _dateController.text =
                                      formattedDate; //set foratted date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            }
                          },
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () async {},
                          child: Text('Agendar Consulta'),
                        ),
                      ],
                    )))));
  }
}
