import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(
    MaterialApp(
      title: 'Mini Curso',
      home: Login(),
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    ),
  );
}
