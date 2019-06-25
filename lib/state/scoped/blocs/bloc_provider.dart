import 'package:flutter/material.dart';
import './count_bloc.dart';

class BlocProvider extends InheritedWidget {
  CountBLoC bLoC = CountBLoC();

  BlocProvider({Key key, Widget child}):super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true; // 需要传入一个InheritedWidget的旧实例,返回值为true的时候更新视图
  static CountBLoC of(BuildContext context) =>
    (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
 }