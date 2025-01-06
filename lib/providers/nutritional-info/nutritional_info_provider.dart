import 'package:flutter/material.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:provider/provider.dart';

class NutritionalInfoProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers

  //? Packages

  //****************************************/
  //? Variables
  bool hasNutritionalInfo = false;
  int currentStep = 0;

  //! Personal Information
  String completeName = '';
  DateTime birthDate = DateTime.now();
  int age = 0;
  String gender = '';
  String maritalStatus = '';
  String address = '';
  String occupation = '';
  String phone = '';
  String email = '';

  //! Nutritional Information
  int numberOfMeals = 0;
  String medicationAllergy = '';
  bool takesSupplement = false;
  String supplementName = '';
  String supplementDose = '';
  String supplementReason = '';
  bool foodVariesWithMood = false;
  bool hasDietPlan = false;
  bool consumesAlcohol = false;
  bool smokes = false;
  bool previousPhysicalActivity = false;
  bool isPregnant = false;
  bool currentPhysicalActivity = false;
  String currentSportsInjuryDuration = '';

  //! Diseases Information
  String diabetes = '';
  String dyslipidemias = '';
  String obesity = '';
  String hypertension = '';
  String cancer = '';
  String hypoHyperthyroidism = '';
  String otherConditions = '';

  //? Setters Variables
  void setHasNutritionalInfo(bool value) {
    hasNutritionalInfo = value;
    notifyListeners();
  }

  //! Personal Information
  void setCompleteName(String value) {
    completeName = value;
    notifyListeners();
  }

  void setBirthDate(DateTime value) {
    birthDate = value;
    notifyListeners();
  }

  void setAge(int value) {
    age = value;
    notifyListeners();
  }

  void setGender(String value) {
    gender = value;
    notifyListeners();
  }

  void setMaritalStatus(String value) {
    maritalStatus = value;
    notifyListeners();
  }

  void setAddress(String value) {
    address = value;
    notifyListeners();
  }

  void setOccupation(String value) {
    occupation = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  //! Nutritional Information
  void setNumberOfMeals(int value) {
    numberOfMeals = value;
    notifyListeners();
  }

  void setMedicationAllergy(String value) {
    medicationAllergy = value;
    notifyListeners();
  }

  void setTakesSupplement(bool value) {
    takesSupplement = value;
    notifyListeners();
  }

  void setSupplementName(String value) {
    supplementName = value;
    notifyListeners();
  }

  void setSupplementDose(String value) {
    supplementDose = value;
    notifyListeners();
  }

  void setSupplementReason(String value) {
    supplementReason = value;
    notifyListeners();
  }

  void setFoodVariesWithMood(bool value) {
    foodVariesWithMood = value;
    notifyListeners();
  }

  void setHasDietPlan(bool value) {
    hasDietPlan = value;
    notifyListeners();
  }

  void setConsumesAlcohol(bool value) {
    consumesAlcohol = value;
  }

  void setSmokes(bool value) {
    smokes = value;
    notifyListeners();
  }

  void setPreviousPhysicalActivity(bool value) {
    previousPhysicalActivity = value;
    notifyListeners();
  }

  void setIsPregnant(bool value) {
    isPregnant = value;
    notifyListeners();
  }

  void setCurrentPhysicalActivity(bool value) {
    currentPhysicalActivity = value;
    notifyListeners();
  }

  void setCurrentSportsInjuryDuration(String value) {
    currentSportsInjuryDuration = value;
    notifyListeners();
  }

  //! Diseases Information
  void setDiabetes(String value) {
    diabetes = value;
    notifyListeners();
  }

  void setDyslipidemias(String value) {
    dyslipidemias = value;
    notifyListeners();
  }

  void setObesity(String value) {
    obesity = value;
    notifyListeners();
  }

  void setHypertension(String value) {
    hypertension = value;
    notifyListeners();
  }

  void setCancer(String value) {
    cancer = value;
    notifyListeners();
  }

  void setHypoHyperthyroidism(String value) {
    hypoHyperthyroidism = value;
    notifyListeners();
  }

  void setOtherConditions(String value) {
    otherConditions = value;
    notifyListeners();
  }

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //****************************************/
  //? Listas

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

  void nextStep() {
    currentStep++;
    notifyListeners();
  }

  void previousStep() {
    currentStep--;
    notifyListeners();
  }

  //? Eliminar toda la data
  void clearData() {
    hasNutritionalInfo = false;
    age = 0;
    notifyListeners();
  }

  //****************************************/
  //**************VALIDADORES***************/
  //****************************************/
  //?

  //****************************************/
  //***************FUNCIONES****************/
  //****************************************/
  //? Convertir fecha a formato legible
  String convertDate(String date) {
    try {
      // Validar longitud de la fecha para evitar errores al usar substring
      if (date.length < 10) {
        throw const FormatException(
            'La fecha proporcionada no tiene el formato esperado.');
      }

      String year = date.substring(0, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);

      // Determinar el nombre del mes
      String monthName = '';
      switch (month) {
        case '01':
          monthName = 'Enero';
          break;
        case '02':
          monthName = 'Febrero';
          break;
        case '03':
          monthName = 'Marzo';
          break;
        case '04':
          monthName = 'Abril';
          break;
        case '05':
          monthName = 'Mayo';
          break;
        case '06':
          monthName = 'Junio';
          break;
        case '07':
          monthName = 'Julio';
          break;
        case '08':
          monthName = 'Agosto';
          break;
        case '09':
          monthName = 'Septiembre';
          break;
        case '10':
          monthName = 'Octubre';
          break;
        case '11':
          monthName = 'Noviembre';
          break;
        case '12':
          monthName = 'Diciembre';
          break;
        default:
          throw Exception('El mes proporcionado no es válido.');
      }

      // Devolver la fecha en el formato esperado
      return '$day de $monthName de $year';
    } catch (e) {
      Logger.logAppError('Error al convertir la fecha: $e');
      return 'Error al convertir la fecha';
    }
  }

  //? Funcion para calcular la Edad
  Future<void> calculateAge(DateTime birthDate) async {
    try {
      final DateTime now = DateTime.now();
      int age = now.year - birthDate.year;

      // Verificar si el cumpleaños ya pasó este año
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }

      setAge(age);
    } catch (e) {
      Logger.logAppError('Error al calcular la edad: $e');
    }
  }

  //? Funcion para obtener data ya existente (Personal Information)
  Future<void> getExistingPersonalInformation(BuildContext context) async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    try {
      showLoading();

      //? Setear la data personal existente
      setCompleteName(
          '${loginProvider.user!.name} ${loginProvider.user!.lastname}');
      setBirthDate(loginProvider.user!.birthdate);
      //? Calcular edad
      calculateAge(loginProvider.user!.birthdate);
      setGender(loginProvider.user!.gender);
      setPhone(loginProvider.user!.phone);
      setEmail(loginProvider.user!.email);
    } catch (e) {
      Logger.logAppError('Error al obtener la data existente: $e');
    } finally {
      hideLoading();
    }
  }

  //? Funcion para obtener data ya existente (Nutritional Information)
  Future<void> getExistingNutritionalInformation(BuildContext context) async {
    try {
      showLoading();
    } catch (e) {
      Logger.logAppError('Error al obtener la data existente: $e');
    } finally {
      hideLoading();
    }
  }
}
