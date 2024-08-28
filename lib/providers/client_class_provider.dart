import 'package:flutter/foundation.dart';
import 'package:pilates/models/response/login_response.dart';

class ClientClassProvider extends ChangeNotifier {
  //Variables de registro
  LoginResponse? _loginResponse;
  DateTime? _selectedDate;
  String? _selectedHour;
  String? _selectedClass;

  //Getters
  LoginResponse? get loginResponse => _loginResponse;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedHour => _selectedHour;
  String? get selectedClass => _selectedClass;

  //Setters
  void setLoginResponse(LoginResponse loginResponse) {
    _loginResponse = loginResponse;
    notifyListeners();
  }

  void setSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void setSelectedHour(String selectedHour) {
    _selectedHour = selectedHour;
    notifyListeners();
  }

  void setSelectedClass(String selectedClass) {
    _selectedClass = selectedClass;
    notifyListeners();
  }

  //Clear all
  void clearAll() {
    _loginResponse = null;
    _selectedDate = null;
    _selectedHour = null;
    _selectedClass = null;
    notifyListeners();
  }

  //Clear Individual
  void clearLoginResponse() {
    _loginResponse = null;
    notifyListeners();
  }

  void clearSelectedDate() {
    _selectedDate = null;
    notifyListeners();
  }

  void clearSelectedHour() {
    _selectedHour = null;
    notifyListeners();
  }

  void clearSelectedClass() {
    _selectedClass = null;
    notifyListeners();
  }
}
