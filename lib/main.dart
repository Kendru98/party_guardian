import 'package:flutter/material.dart';
import 'package:party_guardian/screens/home_page.dart';

import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
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
