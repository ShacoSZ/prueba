import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/main.dart';
import 'package:raccoon_doctor/screens/HomePage.dart';
import 'package:flutter/services.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;

import 'LogInwithPhoneNumber.dart';
import 'VerifyPhoneNumber.dart';

final _auth = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

String verificationID = "";
bool otpVisibility = false;
TextEditingController _codeController = TextEditingController();

class _SignupPageState extends State<SignUpPage> {
  final _SignUpKey = GlobalKey<FormState>();
  TextEditingController _nameOfUser = TextEditingController();
  TextEditingController _secondNameOfUser = TextEditingController();
  TextEditingController _lastnameOfUser = TextEditingController();
  TextEditingController _motherLastnameOfUser = TextEditingController();
  TextEditingController _rfcOfUser = TextEditingController();
  TextEditingController _sexOfUser = TextEditingController();
  TextEditingController _emailOfUser = TextEditingController();
  TextEditingController _phoneOfUser = TextEditingController();
  TextEditingController _addressOfUser = TextEditingController();
  TextEditingController _passwordOfUser = TextEditingController();
  TextEditingController _bloodTypeOfUser = TextEditingController();
  TextEditingController _weightOfUser = TextEditingController();
  TextEditingController _heightOfUser = TextEditingController();
  TextEditingController _medicinesOfUser = TextEditingController();
  TextEditingController _birthdayOfUser = TextEditingController();

  @override
  void initState() {
    super.initState();
    _birthdayOfUser.text = '';
  }

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
                          //inicio primera row
                          Row(
                            children: [
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameOfUser,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Nombre',
                                          labelStyle: TextStyle(
                                              color: const Color(0xFF19969E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 15),
                              SizedBox(
                                width: 160, // Ancho deseado
                                child: TextFormField(
                                  controller: _secondNameOfUser,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Segundo Nombre',
                                    labelStyle: TextStyle(
                                        color: const Color(0xFF19969E)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //fin primera row
                          SizedBox(
                            height: 25,
                          ),
                          //inicio segunda row
                          Row(
                            children: [
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _lastnameOfUser,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Apellido Paterno',
                                          labelStyle: TextStyle(
                                              color: const Color(0xFF19969E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 25),
                              SizedBox(
                                width: 150, // Ancho deseado
                                child: TextFormField(
                                  controller: _motherLastnameOfUser,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Apellido Materno',
                                    labelStyle: TextStyle(
                                        color: const Color(0xFF19969E)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //fin segunda row
                          SizedBox(height: 25),
                          //inicio tercera row
                          DropdownButtonFormField(
                              items: const <DropdownMenuItem<String>>[
                                DropdownMenuItem<String>(
                                  value: 'Masculino',
                                  child: Text('Masculino'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Femenino',
                                  child: Text('Femenino'),
                                ),
                              ],
                              onChanged: (value) {
                                _sexOfUser.text = value!;
                              },
                              style: TextStyle(
                                  color: const Color(0xFF19969E), fontSize: 18),
                              decoration: InputDecoration(
                                labelText: 'Sexo',
                                labelStyle:
                                    TextStyle(color: const Color(0xFF19969E)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10.0),
                              )),
                          //fin tercera row
                          SizedBox(height: 25),
                          //inicio cuarta row
                          Row(
                            children: [
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _rfcOfUser,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'RFC',
                                          labelStyle: TextStyle(
                                              color: const Color(0xFF19969E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 25),
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: TextField(
                                    controller: _birthdayOfUser,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText: 'Cumpleaños',
                                      labelStyle: TextStyle(
                                          color: const Color(0xFF19969E)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  1950), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        if (pickedDate != null) {
                                          print(
                                              pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                          String formattedDate =
                                              DateFormat('yyyy-MM-dd').format(
                                                  pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                          print(
                                              formattedDate); //formatted date output using intl package =>  2022-07-04
                                          //You can format date as per your need

                                          setState(() {
                                            _birthdayOfUser.text =
                                                formattedDate; //set foratted date to TextField value.
                                          });
                                        } else {
                                          print("Date is not selected");
                                        }
                                      }
                                    },
                                  )),
                            ],
                          ),
                          //fin cuarta row
                          SizedBox(height: 25),
                          //inicio quinta row
                          Row(
                            children: [
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _phoneOfUser,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: 'Telefono',
                                          labelStyle: TextStyle(
                                              color: const Color(0xFF19969E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 25),
                              SizedBox(
                                width: 150, // Ancho deseado
                                child: TextFormField(
                                  controller: _addressOfUser,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Domicilio',
                                    labelStyle: TextStyle(
                                        color: const Color(0xFF19969E)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //fin quinta row
                          SizedBox(height: 25),
                          //inicio sexta row
                          TextFormField(
                            controller: _medicinesOfUser,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Preescripcion Anterior',
                              labelStyle:
                                  TextStyle(color: const Color(0xFF19969E)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10.0),
                            ),
                          ),
                          //fin sexta row
                          SizedBox(height: 25),
                          //inicio septima row
                          DropdownButtonFormField(
                              items: const <DropdownMenuItem<String>>[
                                DropdownMenuItem<String>(
                                  value: 'A+',
                                  child: Text('A+'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'A-',
                                  child: Text('A-'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'B+',
                                  child: Text('B+'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'B-',
                                  child: Text('B-'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'AB+',
                                  child: Text('AB+'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'AB-',
                                  child: Text('AB-'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'O+',
                                  child: Text('O+'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'O-',
                                  child: Text('O-'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'N/A',
                                  child: Text('N/A'),
                                ),
                              ],
                              onChanged: (value) {
                                _bloodTypeOfUser.text = value!;
                              },
                              style: TextStyle(
                                  color: const Color(0xFF19969E), fontSize: 18),
                              decoration: InputDecoration(
                                labelText: 'Tipo de Sangre',
                                labelStyle:
                                    TextStyle(color: const Color(0xFF19969E)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10.0),
                              )),
                          //fin septima row
                          SizedBox(height: 25),
                          //inicio octava row
                          Row(
                            children: [
                              SizedBox(
                                  width: 150, // Ancho deseado
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _heightOfUser,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          labelText: 'Altura',
                                          labelStyle: TextStyle(
                                              color: const Color(0xFF19969E)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(width: 15),
                              SizedBox(
                                width: 160, // Ancho deseado
                                child: TextFormField(
                                  controller: _weightOfUser,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelText: 'Peso',
                                    labelStyle: TextStyle(
                                        color: const Color(0xFF19969E)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //fin octava row
                          SizedBox(height: 25),
                          //inicio novena row
                          TextFormField(
                            controller: _emailOfUser,
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
                          ),
                          SizedBox(height: 25),
                          TextFormField(
                            controller: _passwordOfUser,
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
                                    email: _emailOfUser.text,
                                    password: _passwordOfUser.text,
                                  );
                                  // Actualiza el perfil del usuario con su nombre y apellido
                                  await userCredential.user!.updateDisplayName(
                                      _nameOfUser.text + _lastnameOfUser.text);
                                  // Envía un correo electrónico de verificación al usuario
                                  await userCredential.user!
                                      .sendEmailVerification();

                                  postToLaravel(
                                      context,
                                      _nameOfUser.text,
                                      _secondNameOfUser.text,
                                      _lastnameOfUser.text,
                                      _motherLastnameOfUser.text,
                                      _rfcOfUser.text,
                                      _sexOfUser.text,
                                      _emailOfUser.text,
                                      _phoneOfUser.text,
                                      _addressOfUser.text,
                                      _passwordOfUser.text,
                                      _bloodTypeOfUser.text,
                                      _weightOfUser.text,
                                      _heightOfUser.text,
                                      _medicinesOfUser.text,
                                      _birthdayOfUser.text);
                                  // Navega a la página de inicio
                                  //navigateToHomePage(context);
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
                              //navigateToHomePage(context);

                              dialogVerifyPhoneNumber(context, _phoneOfUser);
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

void postToLaravel(
  BuildContext context,
  String _name,
  String _secondname,
  String _lastname,
  String _motherlastname,
  String _rfc,
  String _genre,
  String _email,
  String _phone,
  String _address,
  String _password,
  String _bloodtype,
  String _weight,
  String _height,
  String _medicines,
  String _birthday,
) async {
  String url = 'http://127.0.0.1:8000/api/register-patient';

  Map<String, String> data = {
    'name': _name,
    'second_name': _secondname,
    'lastname': _lastname,
    'mother_lastname': _motherlastname,
    'RFC': _rfc,
    'genre': _genre,
    'email': _email,
    'phone': "52" + _phone,
    'address': _address,
    'password': _password,
    'blood_type': _bloodtype,
    'weight': _weight,
    'height': _height,
    'medicines': _medicines,
    'birthday': _birthday,
  };

  // Realizar la solicitud POST
  http.post(Uri.parse(url), body: data).then((response) {
    if (response.statusCode == 200) {
      // La solicitud fue exitosa, maneja la respuesta aquí
      print(response.body);
    } else {
      // La solicitud falló, maneja el error aquí
      print('Error en la solicitud POST: ${response.statusCode}');
    }
  }).catchError((error) {
    // Manejar errores de conexión u otros errores
    print('Error en la solicitud POST: $error');
  });
}

void dialogVerifyPhoneNumber(
    BuildContext context, TextEditingController _phoneNumberController) {
  _auth.verifyPhoneNumber(
      phoneNumber: "+52" + _phoneNumberController.text,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${e.message}'),
          ),
        );
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
      },
      codeAutoRetrievalTimeout: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed: ${e}'),
          ),
        );
      });
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
