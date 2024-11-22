import 'package:cat_out_of_the_box/src/screens/home.dart';
import 'package:flutter/material.dart';

/// The root widget of the application.
///
/// This [StatelessWidget] sets up the main [MaterialApp] for the app,
/// defining its title, theme, and the home screen.
///
/// - The `title` is used by the operating system (e.g., as the name of the app in recent tasks).
/// - The `theme` specifies the global theme for the application.
/// - The `home` property sets the starting screen of the app to [Home].
class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Out of the Box',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home()
    );
  }
}