import 'package:flutter/material.dart';

// 定义一个BlocBase抽象类
abstract class BlocBase {
  Future getData({String labelId, int page});

  Future onRefresh({String labelId});

  Future onLoadMore({String labelId});

  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final T bloc;
  final Widget child;
  final bool userDispose;

  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
    this.userDispose = true
  }):super(key:key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  /**
   * context.ancestorWidgetOfExactType()是一个为时间复杂度为O(n)的函数，为了检索某种类型的祖先，
   * 它将对widget树 做向上导航，从上下文开始，一次递增一个父，直到完成。如果从上下文到祖先的距离很小（即O(n)结果很少），则可以接受对此函数的调用，否则应该避免。
   */

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {
  @override
  void dispose() {
    if(widget.userDispose) widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}