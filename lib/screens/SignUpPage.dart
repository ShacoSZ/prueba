import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/HomePage.dart';
import 'package:flutter/services.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserON {
  String? name;
  String? lastname;
  String? email;
  String? password;
  String? phone;
}

var usuario = UserON();

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  final _SignUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xFFEDF2F5),
            child: Form(
                key: _SignUpKey,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Crear usuario',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 55),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inserte su Nombre',
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu nombre';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usuario.name = value;
                            },
                          ),
                          SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inserte su Apellido',
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Apellido',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu apellido';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usuario.lastname = value;
                            },
                          ),
                          SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inserte su Correo Electronico',
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usuario.email = value;
                            },
                          ),
                          SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inserte su Telefono',
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Telefono',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu telefono';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usuario.phone = value;
                            },
                          ),
                          SizedBox(height: 16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inserte una Contraseña',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu contraseña';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              usuario.password = value;
                            },
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_SignUpKey.currentState!.validate()) {
                                _SignUpKey.currentState!.save();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Registrando usuario'),
                                  ),
                                );
                                try {
                                  // Crea un nuevo usuario con la dirección de correo electrónico y la contraseña proporcionadas
                                  final userCredential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                    email: usuario.email!,
                                    password: usuario.password!,
                                  );
                                  // Actualiza el perfil del usuario con su nombre y apellido
                                  await userCredential.user!.updateDisplayName(
                                      '${usuario.name} ${usuario.lastname}');
                                  // Envía un correo electrónico de verificación al usuario
                                  await userCredential.user!
                                      .sendEmailVerification();
                                  // Navega a la página de inicio
                                  navigateToHomePage(context);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'El correo electrónico ya está en uso.'),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Error al registrar el usuario.'),
                                      ),
                                    );
                                  }
                                }
                              }
                              navigateToHomePage(context);
                            },
                            child: Text('Crear Cuenta'),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.keyboard_return_sharp,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Regresar al menu',
                                style: TextStyle(color: Colors.black),
                              )),
                        ])))));
  }
}

void navigateToHomePage1(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => MyApp(),
    ),
  );
}

void navigateToHomePage(BuildContext context) {
  Route route = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MyApp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );

  Navigator.push(context, route);
}
