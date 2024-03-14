import 'package:credit_card_animations/widgets/wrapper_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credit card animations',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        textTheme: GoogleFonts.sourceCodeProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const WrapperView(),
    );
  }
}
