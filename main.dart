import 'package:flutter/material.dart';
import './telas/inicio.dart';
import './telas/login.dart';
import './telas/registro.dart';
import './telas/sinal.dart';
import './telas/range.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Login Flutter',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaLogin(),
        '/registro': (context) => const TelaRegistro(),
        '/inicio': (context) => const TelaInicio(),
        '/sinal': (context) => const Sinal(),
        '/range': (context) => const Range(),
      },
    );
  }
}