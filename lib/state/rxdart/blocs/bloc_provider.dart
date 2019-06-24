import 'package:flutter/material.dart';
import './count_bloc.dart';

class BlocProvider extends InheritedWidget {
  final CountBLoC bloC = CountBLoC();
  BlocProvider({Key key, Widget child}):super(key:key, child: child);

  @override
  bool updateShouldNotify(_) => true; // inheritedWidget需要传入一个旧的实例
  static CountBLoC of(BuildContext context) {
    (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloC;
  }
}