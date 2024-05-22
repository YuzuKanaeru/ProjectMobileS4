import 'package:flutter/material.dart';

import 'package:flutter_app/pages/daftar_kandidat.dart';
import 'package:flutter_app/pages/dashboard.dart';
import 'package:flutter_app/pages/hasil_voting.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/petunjuk.dart';
// import 'package:flutter_app/pages/pop_up_keluar.dart';
// import 'package:flutter_app/pages/pop_up_mesage.dart';
import 'package:flutter_app/pages/voting.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: Scaffold(
        body: Login()
      ),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => Dashboard(),
        '/petunjuk': (context) => Petunjuk(),
        '/daftarkandidat':(context) => DaftarKandidat(),
        '/voting':(context) => Voting(),
        '/hasilvoting':(context) => HasilVoting()
      },
    );
  }
}
