import 'package:flutter/material.dart';
import 'util/constants/theme_constants.dart';
import 'util/ui/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeConstants.themeConfiguration(context, true),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const BottomBar(),
    );
  }
}
