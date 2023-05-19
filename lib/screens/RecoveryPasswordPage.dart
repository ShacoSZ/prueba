import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecoveryPasswordPage extends StatefulWidget {
  const RecoveryPasswordPage({super.key});

  @override
  createState() => _RecoveryPasswordState();
}

class _RecoveryPasswordState extends State<RecoveryPasswordPage> {
  final _formRecoveryKey = GlobalKey<FormState>();
  late String _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xFFEDF2F5),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Recuperar Contraseña',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
              child: Form(
            key: _formRecoveryKey,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 95),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingrese Su Correo Electronico',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
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
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 25),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formRecoveryKey.currentState!.validate()) {
                                try {
                                  await _auth.sendPasswordResetEmail(
                                    email: _email,
                                  );
                                  Navigator.pop(context);
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
                                            'Wrong Email provided for that user.'),
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
                            child: const Text('Generar Nueva Contraseña'),
                          ),
                          const SizedBox(width: 25)
                        ],
                      )),
                ],
              ),
            ),
          )),
        ],
      ),
    ));
  }
}
