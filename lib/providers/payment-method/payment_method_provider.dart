import 'package:flutter/material.dart';

class PaymentMethodProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  

  //? Packages

  //****************************************/
  //? Variables

  //? Setters Variables

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //****************************************/
  //? Listas
  

  //? Setters Listas
  

  //****************************************/
  //? Reutilizables
  bool isLoading = false;

  //? Setters Reutilizables
  void showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  //? Eliminar toda la data
  void clearData() {
    notifyListeners();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //?

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? 
}
