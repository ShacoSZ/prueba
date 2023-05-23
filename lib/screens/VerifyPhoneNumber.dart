import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raccoon_doctor/screens/SignUpPage.dart';

import '../main.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final String verificationId;
  const VerifyPhoneNumber({Key? key, required this.verificationId})
      : super(key: key);

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final _PhoneNumberController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify with Phone Number'),
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
            decoration: InputDecoration(hintText: '6 digit code'),
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
              onPressed: () async {
                final Credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: _PhoneNumberController.text);
                try {
                  final userCredential = FirebaseAuth.instance.currentUser;
                  if (userCredential != null) {
                    await userCredential.linkWithCredential(Credential);
                    navigateToHomePage(context);
                  } else {
                    await _auth.signInWithCredential(Credential);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed: ${e.toString()}'),
                    ),
                  );
                }
              },
              child: const Text('Verificar'))
        ]),
      ),
    );
  }
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
