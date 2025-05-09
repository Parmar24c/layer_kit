import 'package:flutter/material.dart';

enum ViewState { initial, loading, loaded, error }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;
  String _errorMessage = '';

  ViewState get state => _state;
  String get errorMessage => _errorMessage;
  bool get isLoading => _state == ViewState.loading;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setInitial() {
    _state = ViewState.initial;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _state = ViewState.error;
    notifyListeners();
  }

  void setLoading() {
    _state = ViewState.loading;
    notifyListeners();
  }

  void setLoaded() {
    _state = ViewState.loaded;
    notifyListeners();
  }
}
