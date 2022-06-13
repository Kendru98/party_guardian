import 'package:flutter/material.dart';
import 'package:party_guardian/screens/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'theme/theme.dart';

void main() {
  initializeDateFormatting('pl', null).then((_) => runApp(MyApp()));
  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeProvider().getTheme(),
      home: HomeScreen(),
    );
  }
}
