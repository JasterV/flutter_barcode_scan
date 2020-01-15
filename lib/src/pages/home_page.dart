import 'package:flutter/material.dart';
import 'package:food_barcode_scan/src/Bloc/provider.dart';
import 'package:food_barcode_scan/src/services/api_wrapper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        title: Text("Barcode Scanner"),
      ),
      body: StreamBuilder(
        stream: bloc.product,
        initialData: "Hello!",
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent[400],
        label: Text("Scan", style: TextStyle(fontSize: 15.0)),
        icon: Icon(Icons.camera),
        onPressed: () => APIWrapper.scanCode(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
