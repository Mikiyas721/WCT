import '../../core/utils/disposable.dart';
import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  final T value;

  Provider({
    Key key,
    @required this.value,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static T of<T>(BuildContext context) {
    Provider<T> widget =
        context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    return widget?.value;
  }
}

class BlocProvider<T extends Disposable> extends StatefulWidget {
  final T Function() blocFactory;
  final void Function(T) onInit;
  final void Function(T) onDispose;
  final Widget Function(BuildContext, T) builder;

  const BlocProvider({
    Key key,
    @required this.blocFactory,
    this.onInit,
    @required this.builder,
    this.onDispose,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Disposable> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocFactory();
    widget.onInit?.call(bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      value: bloc,
      child: Builder(builder: (context) {
        return widget.builder(context, bloc);
      }),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    widget.onDispose?.call(bloc);
    super.dispose();
  }
}
