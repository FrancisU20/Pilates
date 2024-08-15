import 'dart:io';

import 'package:flutter/foundation.dart';

class RegisterProvider extends ChangeNotifier {
  //Variables de registro
  String? _name;
  String? _lastname;
  String? _phone;
  String? _email;
  DateTime? _birthday;
  String? _password;
  String? _gender;
  File? _imageFile;

  //Getters
  String? get name => _name;
  String? get lastname => _lastname;
  String? get phone => _phone;
  String? get email => _email;
  DateTime? get birthday => _birthday;
  String? get password => _password;
  String? get gender => _gender;
  File? get imageFile => _imageFile;

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

  void setImageFile(File imageFile) {
    _imageFile = imageFile;
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
    notifyListeners();
  }
}
