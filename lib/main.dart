import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:raccoon_doctor/screens/HomePage.dart';
import 'package:raccoon_doctor/screens/ConsultationMedicalPage.dart';
import 'package:raccoon_doctor/screens/LoginPage.dart';
import 'package:raccoon_doctor/screens/SignUpDoctorPage.dart';
import 'package:raccoon_doctor/screens/SignUpPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class UserState extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userState = UserState();
  int actualPage = 0;
  List<Widget> pages = [HomePage(), FavoritePage()];
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          isAuth = true;
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: userState),
        ],
        child: MaterialApp(
          title: 'Raccoon Rappi',
          debugShowCheckedModeBanner: true,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            primaryColor: const Color(0xFF04557D),
          ),
          home: isAuth
              ? Scaffold(
                  body: pages[actualPage],
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: (index) {
                      setState(() {
                        actualPage = index;
                      });
                    },
                    currentIndex: actualPage,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: 'Pagina Principal'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: 'Restaurantes Favoritos')
                    ],
                  ),
                )
              : Center(
                  child: Scaffold(
                    body: LoginForm(),
                  ),
                ),
        ));
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
