import 'package:rxdart/rxdart.dart';

class ProductsBloc{
  final _subject = BehaviorSubject<String>();

  Stream<String> get product => _subject.stream;

  Function(String) get addData => _subject.sink.add;
  Function(String) get addError => _subject.sink.addError;
  
  dispose(){
    _subject.close();
  }


  
}