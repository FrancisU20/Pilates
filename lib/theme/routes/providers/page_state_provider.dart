import 'package:flutter/material.dart';

class PageStateProvider extends ChangeNotifier{
  //? Variable de ruta activa
  String activeRoute = '';

  //? Setter de la ruta activa
  void setActiveRoute(String route){
    activeRoute = route;
    notifyListeners();
  }

  //? Clear de la ruta activa
  void clearActiveRoute(){
    activeRoute = '';
    notifyListeners();
  }

}