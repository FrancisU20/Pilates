import 'package:flutter/foundation.dart';
import 'package:pilates/models/login/login_model.dart';
import 'package:pilates/models/response/all_client_class_response.dart';
import 'package:pilates/models/response/client_plans_response.dart';

class ClientClassProvider extends ChangeNotifier {
  //Variables de registro
  LoginModel? _loginResponse;
  DateTime? _selectedDate;
  String? _selectedHour;
  String? _selectedClass;
  List<ClientPlansResponse>? _clientPlans;
  ClientPlansResponse? _currentPlan;
  List<AllClientsPlansResponse>? _allClientsPlansResponse;

  //Getters
  LoginModel? get loginResponse => _loginResponse;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedHour => _selectedHour;
  String? get selectedClass => _selectedClass;
  List<ClientPlansResponse>? get clientPlans => _clientPlans;
  ClientPlansResponse? get currentPlan => _currentPlan;
  List<AllClientsPlansResponse>? get allClientsPlansResponse =>
      _allClientsPlansResponse;

  //Setters
  void setLoginModel(LoginModel loginResponse) {
    _loginResponse = loginResponse;
    notifyListeners();
  }

  void setSelectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  void setSelectedHour(String? selectedHour) {
    _selectedHour = selectedHour;
    notifyListeners();
  }

  void setSelectedClass(String selectedClass) {
    _selectedClass = selectedClass;
    notifyListeners();
  }

  void setClientPlans(List<ClientPlansResponse> clientPlans) {
    _clientPlans = clientPlans;
    notifyListeners();
  }

  void setCurrentPlan(ClientPlansResponse currentPlan) {
    _currentPlan = currentPlan;
    notifyListeners();
  }

  void setAllClientsPlansResponse(
      List<AllClientsPlansResponse> allClientsPlansResponse) {
    _allClientsPlansResponse = allClientsPlansResponse;
    notifyListeners();
  }

  //Clear all
  void clearAll() async {
    _loginResponse = null;
    _selectedDate = null;
    _selectedHour = null;
    _selectedClass = null;
    _clientPlans = null;
    _currentPlan = null;
    _allClientsPlansResponse = null;
    notifyListeners();
  }

  //Clear Individual
  void clearLoginModel() {
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

  void clearClientPlans() {
    _clientPlans = null;
    notifyListeners();
  }

  void clearCurrentPlan() {
    _currentPlan = null;
    notifyListeners();
  }

  void clearAllClientsPlansResponse() {
    _allClientsPlansResponse = null;
    notifyListeners();
  }
}
