import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/screens/SignUpPage.dart';
import 'package:raccoon_doctor/screens/HomePage.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/RecoveryPasswordPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'LogInwithPhoneNumber.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFEDF2F5),
        child: ListView(children: [
          const Text('Iniciar Sesión',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 155),
                  const Text(
                    'Ingresa tu Correo Electronico',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 9),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: Color(0xFF19969E)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value.trim();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingresa tu Contraseña',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 9),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: Color(0xFF19969E)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa tu contraseña';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value.trim();
                    },
                  ),
                  TextButton(
                    onPressed: () => navigateToRecoveryPasswordScreen(context),
                    child: const Text('Olvide mi Contraseña'),
                  ),
                  const SizedBox(height: 16),
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 25),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final UserCredential userCredential =
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                    email: _email,
                                    password: _password,
                                  );
                                  final userState = context.read<UserState>();
                                  userState.setUser(userCredential.user);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'No user found for that email.'),
                                      ),
                                    );
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Wrong password provided for that user.'),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Radio de la esquina redondeada
                              ),
                            ),
                            child: const Text('Iniciar sesión'),
                          ),
                          const SizedBox(width: 25),
                          ElevatedButton(
                            onPressed: () => navigateToSignUpScreen(context),
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Registrate Aquí',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 23)
                        ],
                      )),
                ],
              ),
            ),
          ),
        ]));
  }
}

void navigateToSignUpScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => SignUpPage(),
    ),
  );
}

void navigateToRecoveryPasswordScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => RecoveryPasswordPage(),
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
