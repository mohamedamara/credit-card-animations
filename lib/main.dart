import 'package:flutter/material.dart';
import 'widgets/wrapper_view.dart';
import 'themes/custom_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment card animations',
      themeMode: ThemeMode.light,
      theme: CustomTheme.getTheme(context),
      home: const WrapperView(),
    );
  }
}
