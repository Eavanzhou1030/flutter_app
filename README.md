# flutter_application

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


## 项目结构

* blocs (bloc相关)

* common (常用类，例如常量Constant)

* data (网络数据层)

* db (数据库)

* event (事件类)

* models (实体类)

* res (资源文件, string, colors, dimens, styles)

* ui (界面相关page, dialog, widget)

* utils (工具类)

## flutter状态管理: https://www.codercto.com/a/77086.html

* 局部状态管理：flutter中提供了InheritedWiget控件来实现局部状态管理，当InheritedWidget发生变化的时候，子树中所有依赖的Widget都会rebuild

* 全局状态管理：flutter中没有提供全局状态管理

## InheritedWidget实现局部状态管理

* 优点：

  1、自动订阅

  2、自动通知

* 缺点：

  1、无法分离视图逻辑和业务逻辑

  2、无法定向通知/指向性通知

## 全局状态管理: Scoped Model（只是将InheritedWidget封装了一下，继承了InheritedWidget的所有优缺点）

* 优点：

  1、自定订阅

  2、自动通知

  3、上手容易

* 缺点：

  1、无法分离视图逻辑和业务逻辑

  2、无法定向通知、指向性的通知

## 全局状态管理 redux（redux将数据和视图分离，由数据驱动视图渲染，解决scoped Model中的视图和业务无法分离的问题）

### Store实现监听的过程

* Store是一个Model类，内部存储着一个State

* StoreProvider是一个InheritedWidget，内部存储着一个Store(数据中心)

* StoreConnector是一个StoreStreamListener,本质是一个StreamBuilder, 它内部是Stream<ViewModel>,这个Stream是由Store中的ChangeController这个StreamController的Stream调用Map方法得到

* StoreStreamListener通过监听Stream完成视图重建。

总结：StoreConnector负责将数据中心的Stream<State>变成Stream<ViewModel>，然后StoreStreamListener负责监听Stream<ViewModel>的变化更新widget


### 视图与业务之间数据与渲染响应的问题

* 1、 view层发出Action

* 2、Store中的dispatch将这个action转化为Stream<State>,并添加到ChangeController的Stream<State>中等待执行。

* 3、StoreStreamListener监听到新的Stream<State>流入，把流入的State按照业务之前规定的Convert成ViewModel,并将其传入到Stream<ViewModel>中

* 4、View层监听到新的Stream流入，rebuild整个view

### 优点

* 自动订阅

* 自动通知

* 可以定向通知

* 视图和业务分离

## 全局状态管理： BLoC(将视图和数据分离，由数据变化驱动视图渲染)

### BLoC和Redux的主要区别是：

* Redux必须要有一个store才能存放所有的数据，当数据变化的时候由数据中心调用convert方法将对应的state转化为相应的ViewModel，然后通知子widget更新视图。

* BLoC中没有Store的概念，只有一个StreamController，但是这个Controller并不存放数据，只处理数据，并且BLoC中并没有convert方法，View直接将state转化为ViewModel


## AutomaticKeepAliveClientMixin切换tab的时候，将tab的内容保存在内存中
Flutter tab切换之后保存tab的状态，flutter中为了节约内存不会保存widget的状态，widget都是临时变量。使用TabBar, TabBarView的时候，切换tab之后initState会被切换一次。
添加AutomaticKeepAliveClientMixin并设置为true，这样就能保持当前不被initState

