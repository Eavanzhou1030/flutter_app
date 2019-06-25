

import 'package:flutter/material.dart';
import 'package:flutter_application/ui/pages/user/user_login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '一个flutter应用',
      home: UserLoginPage(),
    );
  }
}