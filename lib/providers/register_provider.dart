import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/models/plan/plan_model.dart';

class RegisterProvider extends ChangeNotifier {
  //Variables de registro
  String? _name;
  String? _lastname;
  String? _phone;
  String? _email;
  DateTime? _birthday;
  String? _password;
  String? _gender;
  XFile? _imageFile;
  String? _imageUrl;
  String? _dni;
  PlanModel? _selectedPlan;
  XFile? _transferImageFile;
  String? _transferImageUrl;

  //Getters
  String? get name => _name;
  String? get lastname => _lastname;
  String? get phone => _phone;
  String? get email => _email;
  DateTime? get birthday => _birthday;
  String? get password => _password;
  String? get gender => _gender;
  XFile? get imageFile => _imageFile;
  String? get imageUrl => _imageUrl;
  String? get dni => _dni;
  PlanModel? get selectedPlan => _selectedPlan;
  XFile? get transferImageFile => _transferImageFile;
  String? get transferImageUrl => _transferImageUrl;

  //Setters
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setLastname(String lastname) {
    _lastname = lastname;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setBirthday(DateTime birthday) {
    _birthday = birthday;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setImageFile(XFile imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }

  void setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  void setDni(String dni) {
    _dni = dni;
    notifyListeners();
  }

  void setSelectedPlan(PlanModel selectedPlan) {
    _selectedPlan = selectedPlan;
    notifyListeners();
  }

  void setTransferImageFile(XFile transferImageFile) {
    _transferImageFile = transferImageFile;
    notifyListeners();
  }

  void setTransferImageUrl(String transferImageUrl) {
    _transferImageUrl = transferImageUrl;
    notifyListeners();
  }

  // Clear functions
  void clearName() {
    _name = null;
    notifyListeners();
  }

  void clearLastname() {
    _lastname = null;
    notifyListeners();
  }

  void clearPhone() {
    _phone = null;
    notifyListeners();
  }

  void clearEmail() {
    _email = null;
    notifyListeners();
  }

  void clearBirthday() {
    _birthday = null;
    notifyListeners();
  }

  void clearPassword() {
    _password = null;
    notifyListeners();
  }

  void clearGender() {
    _gender = null;
    notifyListeners();
  }

  void clearImageFile() {
    _imageFile = null;
    notifyListeners();
  }

  void clearImageUrl() {
    _imageUrl = null;
    notifyListeners();
  }

  void clearDni() {
    _dni = null;
    notifyListeners();
  }

  void clearSelectedPlan() {
    _selectedPlan = null;
    notifyListeners();
  }

  void clearTransferImageFile() {
    _transferImageFile = null;
    notifyListeners();
  }

  void clearTransferImageUrl() {
    _transferImageUrl = null;
    notifyListeners();
  }

  //Clear all
  void clearAll() {
    _name = null;
    _lastname = null;
    _phone = null;
    _email = null;
    _birthday = null;
    _password = null;
    _gender = null;
    _imageFile = null;
    _imageUrl = null;
    _dni = null;
    _selectedPlan = null;
    _transferImageFile = null;
    _transferImageUrl = null;
    notifyListeners();
  }
}
