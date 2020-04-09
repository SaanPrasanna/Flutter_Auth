import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_auth/root_page.dart';
import 'auth.dart';

void main() => runApp(
  DevicePreview(
    builder: (context) => MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale, // <--- Add the locale
      builder: DevicePreview.appBuilder,
      home: RootPage(auth: new Auth()),
    );
  }
}