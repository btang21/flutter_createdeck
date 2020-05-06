import 'package:flutter/material.dart';
import 'mutli_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
        //platform: TargetPlatform.iOS,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiForm(),
    );
  }
}