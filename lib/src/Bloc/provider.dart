import 'package:flutter/material.dart';
import 'package:food_barcode_scan/src/Bloc/products_bloc.dart';

class Provider extends InheritedWidget {
  final bloc = ProductsBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ProductsBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().bloc;
  }
}
