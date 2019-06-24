import 'package:meta/meta.dart';

/**
 * state中的所有数据都是只读的，redux中必须通过reducer来更新store中的数据
 */

// immutable中的数据一旦创建，就不能改变，对immutable对象的操作会返回一个新的immutable对象

@immutable
class CountState {
  final int _count;
  get count => _count;

  CountState(this._count);
  CountState.initState(): _count = 0;
}

/**
 * 定义操作该State的全部Action
 * 增加一个count的动作
 */
enum Action {increment}

/**
 * reducer会根据action生成新的CountState
 */
CountState reducer(CountState state, action) {
  // 匹配action
  if(action == Action.increment) {
    return CountState(state.count + 1);
  }
  return state;
}
