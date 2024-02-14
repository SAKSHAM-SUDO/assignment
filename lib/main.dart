import 'package:assignment/screens/auth/auth.dart';
import 'package:assignment/utils/router.dart';
import 'package:assignment/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => const AuthScreen());
        });
  }
}
