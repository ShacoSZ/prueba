import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/screens/SignUpPage.dart';
import 'package:raccoon_doctor/screens/HomePage.dart';
import 'package:raccoon_doctor/main.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ingresa tus datos de inicio de sesión',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
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
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
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
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: _email,
                          password: _password,
                        );
                        final userState = context.read<UserState>();
                        userState.setUser(userCredential.user);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No user found for that email.'),
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Wrong password provided for that user.'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text('Iniciar sesión'),
                ),
                SizedBox(width: 50),
                TextButton(
                  onPressed: () => navigateToSignUpScreen(context),
                  child: Text('Registrate Aquí'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToSignUpScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => SignUpPage(),
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
