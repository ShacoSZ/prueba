import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'VerifyPhoneNumber.dart';

class LogInwithPhoneNumber extends StatefulWidget {
  const LogInwithPhoneNumber({Key? key}) : super(key: key);

  @override
  _LogInwithPhoneNumberState createState() => _LogInwithPhoneNumberState();
}

class _LogInwithPhoneNumberState extends State<LogInwithPhoneNumber> {
  final _PhoneNumberController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In with Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _PhoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(hintText: '+52 8714748410'),
          ),
          SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  loading = true;
                });
                _auth.verifyPhoneNumber(
                    phoneNumber: "+52" + _PhoneNumberController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed: ${e.message}'),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    },
                    codeSent: (String verificationId, int? Token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifyPhoneNumber(
                            verificationId: verificationId,
                          ),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed: ${e}'),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    });
              },
              child: const Text('Iniciar Sesion'))
        ]),
      ),
    );
  }
}
