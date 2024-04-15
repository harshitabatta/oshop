import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<DocumentReference> _Cart = [];
  List<DocumentReference> get Cart => _Cart;
  set Cart(List<DocumentReference> _value) {
    _Cart = _value;
  }

  void addToCart(DocumentReference _value) {
    _Cart.add(_value);
  }

  void removeFromCart(DocumentReference _value) {
    _Cart.remove(_value);
  }

  void removeAtIndexFromCart(int _index) {
    _Cart.removeAt(_index);
  }

  void updateCartAtIndex(
    int _index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    _Cart[_index] = updateFn(_Cart[_index]);
  }

  void insertAtIndexInCart(int _index, DocumentReference _value) {
    _Cart.insert(_index, _value);
  }

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  set totalPrice(double _value) {
    _totalPrice = _value;
  }
}
