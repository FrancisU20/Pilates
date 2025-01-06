import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/controllers/nutritional-info/nutritional_info_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/nutritional-info/nutritional_data_model.dart';
import 'package:pilates/models/nutritional-info/nutritional_info_create_model.dart';
import 'package:pilates/models/nutritional-info/nutritional_info_model.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class NutritionalInfoProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  NutritionalInfoController nutritionalInfoController =
      NutritionalInfoController();

  //? Packages

  //****************************************/
  //? Variables
  int currentStep = 0;
  bool isEditable = false;

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
  bool? takesSupplement;
  String supplementName = '';
  String supplementDose = '';
  String supplementReason = '';
  bool? foodVariesWithMood;
  bool? hasDietPlan;
  bool? consumesAlcohol;
  bool? smokes;
  bool? previousPhysicalActivity;
  bool? isPregnant;
  bool? currentPhysicalInjury;
  String currentSportsInjuryDuration = '';

  //! Diseases Information
  String diabetes = '';
  String dyslipidemias = '';
  String obesity = '';
  String hypertension = '';
  String cancer = '';
  String hypoHyperthyroidism = '';
  String otherConditions = '';

  //! Anthropometric Data
  double weight = 0.0;
  double height = 0.0;
  double neckCircumference = 0.0;
  double waistCircumference = 0.0;
  double hipCircumference = 0.0;

  //! Validado todo el form
  bool validateForm = false;

  //? Setters Variables
  void setIsEditable(bool value) {
    isEditable = value;
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

  void setCurrentPhysicalInjury(bool value) {
    currentPhysicalInjury = value;
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

  //! Anthropometric Data
  void setWeight(double value) {
    weight = value;
    notifyListeners();
  }

  void setHeight(double value) {
    height = value;
    notifyListeners();
  }

  void setNeckCircumference(double value) {
    neckCircumference = value;
    notifyListeners();
  }

  void setWaistCircumference(double value) {
    waistCircumference = value;
    notifyListeners();
  }

  void setHipCircumference(double value) {
    hipCircumference = value;
    notifyListeners();
  }

  //! Validar todo el form
  void setValidateForm(bool value) {
    validateForm = value;
    notifyListeners();
  }

  //****************************************/
  //? Objetos
  NutritionalInfoModel? nutritionalInfo;

  //? Setters Objetos
  void setNutritionalInfo(NutritionalInfoModel value) {
    nutritionalInfo = value;
    notifyListeners();
  }

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
  void clearNutritionalInfo() {
    nutritionalInfo = null;
    notifyListeners();
  }

  void clearData() {
    isEditable = false;
    clearNutritionalInfo();
    age = 0;
    completeName = '';
    birthDate = DateTime.now();
    gender = '';
    maritalStatus = '';
    address = '';
    occupation = '';
    phone = '';
    email = '';
    numberOfMeals = 0;
    medicationAllergy = '';
    takesSupplement = null;
    supplementName = '';
    supplementDose = '';
    supplementReason = '';
    foodVariesWithMood = null;
    hasDietPlan = null;
    consumesAlcohol = null;
    smokes = null;
    previousPhysicalActivity = null;
    isPregnant = null;
    currentPhysicalInjury = null;
    currentSportsInjuryDuration = '';
    diabetes = '';
    dyslipidemias = '';
    obesity = '';
    hypertension = '';
    cancer = '';
    hypoHyperthyroidism = '';
    otherConditions = '';
    weight = 0.0;
    height = 0.0;
    neckCircumference = 0.0;
    waistCircumference = 0.0;
    hipCircumference = 0.0;
    currentStep = 0;
    validateForm = false;
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

  //? Validar toda la informacion
  Future<void> validateNutritionalInfo(BuildContext context) async {
    try {
      //! Personal Information
      if (maritalStatus.isEmpty) {
        throw Exception('Por favor, ingresa estado civil.');
      }
      if (address.isEmpty) {
        throw Exception('Por favor, ingresa tu dirección.');
      }
      if (occupation.isEmpty) {
        throw Exception('Por favor, ingresa tu ocupación.');
      }

      //! Eating Habits
      if (numberOfMeals == 0) {
        throw Exception(
            'Por favor, selecciona el número de comidas que realizas al día.');
      }
      if (medicationAllergy.isEmpty) {
        throw Exception(
            'Por favor, ingresa si tienes alguna alergia a medicamentos.');
      }

      if (takesSupplement == null) {
        throw Exception(
            'Por favor, selecciona si tomas suplementos alimenticios.');
      }
      if (takesSupplement != null && takesSupplement == true) {
        if (supplementName.isEmpty) {
          throw Exception(
              'Respondiste que tomas suplementos, por favor ingresa el nombre del suplemento.');
        }
        if (supplementDose.isEmpty) {
          throw Exception(
              'Respondiste que tomas suplementos, por favor ingresa la dosis del suplemento.');
        }
        if (supplementReason.isEmpty) {
          throw Exception(
              'Respondiste que tomas suplementos, por favor ingresa por qué tomas el suplemento.');
        }
      }
      if (foodVariesWithMood == null) {
        throw Exception(
            'Por favor, selecciona si tu alimentación varía con tu estado de ánimo.');
      }
      if (hasDietPlan == null) {
        throw Exception(
            'Por favor, selecciona si tienes un plan de alimentación.');
      }
      if (consumesAlcohol == null) {
        throw Exception('Por favor, selecciona si consumes alcohol.');
      }
      if (smokes == null) {
        throw Exception('Por favor, selecciona si fumas.');
      }

      if (previousPhysicalActivity == null) {
        throw Exception(
            'Por favor, selecciona si realizabas actividad física anteriormente.');
      }

      if (currentPhysicalInjury == null) {
        throw Exception(
            'Por favor, selecciona si realizas actividad física actualmente.');
      }
      if (isPregnant == null) {
        throw Exception('Por favor, selecciona si estás embarazada.');
      }

      if (currentPhysicalInjury == null) {
        throw Exception(
            'Por favor, selecciona si tienes una lesión por actividad física.');
      }
      if (currentPhysicalInjury != null && currentPhysicalInjury == true) {
        if (currentSportsInjuryDuration.isEmpty) {
          throw Exception(
              'Respondiste que tienes una lesión, por favor ingresa la duración de la lesión.');
        }
      }

      //! Diseases Information
      if (diabetes.isEmpty) {
        throw Exception('Por favor, selecciona si tienes diabetes.');
      }
      if (dyslipidemias.isEmpty) {
        throw Exception('Por favor, selecciona si tienes dislipidemias.');
      }
      if (obesity.isEmpty) {
        throw Exception('Por favor, selecciona si tienes obesidad.');
      }
      if (hypertension.isEmpty) {
        throw Exception('Por favor, selecciona si tienes hipertensión.');
      }
      if (cancer.isEmpty) {
        throw Exception('Por favor, selecciona si tienes cáncer.');
      }
      if (hypoHyperthyroidism.isEmpty) {
        throw Exception(
            'Por favor, selecciona si tienes hipotiroidismo o hipertiroidismo.');
      }
      if (otherConditions.isEmpty) {
        throw Exception('Por favor, ingresa si tienes otras condiciones.');
      }

      //! Anthropometric Data
      if (weight == 0.0) {
        throw Exception('Por favor, ingresa tu peso.');
      }

      if (height == 0.0) {
        throw Exception('Por favor, ingresa tu estatura.');
      }

      if (neckCircumference == 0.0) {
        throw Exception('Por favor, ingresa la circunferencia de tu cuello.');
      }

      if (waistCircumference == 0.0) {
        throw Exception('Por favor, ingresa la circunferencia de tu cintura.');
      }

      if (hipCircumference == 0.0) {
        throw Exception('Por favor, ingresa la circunferencia de tu cadera.');
      }

      setValidateForm(true);
    } catch (e) {
      setValidateForm(false);
      Logger.logAppError('Error al validar el primer paso:$e');
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    }
  }

  //? Funcion que crea un json con toda la información
  Future<NutritionalDataModel> createNutritionalInfoJson() async {
    try {
      NutritionalDataModel nutritionalInfo = NutritionalDataModel(
        personalInformation: PersonalInformation(
          completeName: completeName,
          birthDate: birthDate.toString(),
          age: age,
          gender: gender,
          maritalStatus: maritalStatus,
          address: address,
          occupation: occupation,
          phone: phone,
          email: email,
        ),
        eatingHabits: EatingHabits(
          numberOfMeals: numberOfMeals,
          medicationAllergy: medicationAllergy,
          takesSupplement: takesSupplement,
          supplementName: supplementName,
          supplementDose: supplementDose,
          supplementReason: supplementReason,
          foodVariesWithMood: foodVariesWithMood,
          hasDietPlan: hasDietPlan,
          consumesAlcohol: consumesAlcohol,
          smokes: smokes,
          previousPhysicalActivity: previousPhysicalActivity,
          isPregnant: isPregnant,
          currentPhysicalInjury: currentPhysicalInjury,
          currentSportsInjuryDuration: currentSportsInjuryDuration,
        ),
        diseasesInformation: DiseasesInformation(
          diabetes: diabetes,
          dyslipidemias: dyslipidemias,
          obesity: obesity,
          hypertension: hypertension,
          cancer: cancer,
          hypoHyperthyroidism: hypoHyperthyroidism,
          otherConditions: otherConditions,
        ),
        anthropometricData: AnthropometricData(
          weight: weight,
          height: height,
          neckCircumference: neckCircumference,
          waistCircumference: waistCircumference,
          hipCircumference: hipCircumference,
        ),
      );

      return nutritionalInfo;
    } catch (e) {
      Logger.logAppError(
          'Error al crear el json de la informacion nutricional: $e');
      throw Exception('Error al crear el json de la informacion nutricional.');
    }
  }

  //? Enviar la informacion nutricional
  Future<void> createNutritionalInfo(BuildContext context) async {
    try {
      showLoading();
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

      NutritionalDataModel nutritionalData = await createNutritionalInfoJson();

      NutritionalInfoCreateModel nutritionalInfoModel =
          NutritionalInfoCreateModel(
        userId: loginProvider.user!.id ?? '',
        nutritionalData: jsonEncode(nutritionalData.toJson()),
      );

      StandardResponse<NutritionalInfoModel> createNutritionalInfoResponse =
          await nutritionalInfoController
              .createNutritionalInfo(nutritionalInfoModel);

      if (!context.mounted) return;

      CustomSnackBar.show(
        context,
        createNutritionalInfoResponse.message,
        SnackBarType.success,
      );
    } catch (e) {
      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
  }

  //? Obtener ficha nutricional del cliente
  Future<void> getUserNutritionalInfo(BuildContext context) async {
    try {
      showLoading();
      LoginProvider loginProvider =
          Provider.of<LoginProvider>(context, listen: false);

      StandardResponse<NutritionalInfoModel> userNutritionalInfoResponse =
          await nutritionalInfoController
              .getUserNutritionalInfo(loginProvider.user!.id ?? '');

      setNutritionalInfo(userNutritionalInfoResponse.data!);

      if (!context.mounted) return;
      CustomSnackBar.show(
        context,
        userNutritionalInfoResponse.message,
        SnackBarType.success,
      );
    } catch (e) {

      CustomSnackBar.show(context, e.toString(), SnackBarType.error);
    } finally {
      hideLoading();
    }
  }

  //? FUncion de llenado automatico de variables
  Future<void> fillNutritionalInfo() async {
    try {
      if (nutritionalInfo != null) {
        NutritionalDataModel nutritionalData = nutritionalInfo!.nutritionalData;
        //! Personal Information
        setCompleteName(
            nutritionalData.personalInformation?.completeName ?? '');
        setBirthDate(DateTime.parse(
            nutritionalData.personalInformation?.birthDate ?? ''));
        setGender(nutritionalData.personalInformation?.gender ?? '');
        setMaritalStatus(
            nutritionalData.personalInformation?.maritalStatus ?? '');
        setAddress(nutritionalData.personalInformation?.address ?? '');
        setOccupation(nutritionalData.personalInformation?.occupation ?? '');
        setPhone(nutritionalData.personalInformation?.phone ?? '');
        setEmail(nutritionalData.personalInformation?.email ?? '');

        //! Eating Habits
        setNumberOfMeals(nutritionalData.eatingHabits?.numberOfMeals ?? 0);
        setMedicationAllergy(
            nutritionalData.eatingHabits?.medicationAllergy ?? '');
        setTakesSupplement(
            nutritionalData.eatingHabits?.takesSupplement ?? false);
        setSupplementName(nutritionalData.eatingHabits?.supplementName ?? '');
        setSupplementDose(nutritionalData.eatingHabits?.supplementDose ?? '');
        setSupplementReason(
            nutritionalData.eatingHabits?.supplementReason ?? '');
        setFoodVariesWithMood(
            nutritionalData.eatingHabits?.foodVariesWithMood ?? false);
        setHasDietPlan(nutritionalData.eatingHabits?.hasDietPlan ?? false);
        setConsumesAlcohol(
            nutritionalData.eatingHabits?.consumesAlcohol ?? false);
        setSmokes(nutritionalData.eatingHabits?.smokes ?? false);
        setPreviousPhysicalActivity(
            nutritionalData.eatingHabits?.previousPhysicalActivity ?? false);
        setIsPregnant(nutritionalData.eatingHabits?.isPregnant ?? false);
        setCurrentPhysicalInjury(
            nutritionalData.eatingHabits?.currentPhysicalInjury ?? false);
        setCurrentSportsInjuryDuration(
            nutritionalData.eatingHabits?.currentSportsInjuryDuration ?? '');

        //! Diseases Information
        setDiabetes(nutritionalData.diseasesInformation?.diabetes ?? '');
        setDyslipidemias(
            nutritionalData.diseasesInformation?.dyslipidemias ?? '');
        setObesity(nutritionalData.diseasesInformation?.obesity ?? '');
        setHypertension(
            nutritionalData.diseasesInformation?.hypertension ?? '');
        setCancer(nutritionalData.diseasesInformation?.cancer ?? '');
        setHypoHyperthyroidism(
            nutritionalData.diseasesInformation?.hypoHyperthyroidism ?? '');
        setOtherConditions(
            nutritionalData.diseasesInformation?.otherConditions ?? '');

        //! Anthropometric Data
        setWeight(nutritionalData.anthropometricData?.weight ?? 0.0);
        setHeight(nutritionalData.anthropometricData?.height ?? 0.0);
        setNeckCircumference(
            nutritionalData.anthropometricData?.neckCircumference ?? 0.0);
        setWaistCircumference(
            nutritionalData.anthropometricData?.waistCircumference ?? 0.0);
        setHipCircumference(
            nutritionalData.anthropometricData?.hipCircumference ?? 0.0);
      } else {
        throw Exception('No hay información nutricional para llenar.');
      }
    } catch (e) {
      Logger.logAppError('No hay información nutricional para llenar: $e');
    }
  }

  //? Actualizar todos los TextEditingControllers
  Future<void> updateAllTextEditingControllers(
      TextEditingController completeNameController,
      TextEditingController birthDateController,
      TextEditingController ageController,
      TextEditingController genderController,
      TextEditingController maritalStatusController,
      TextEditingController addressController,
      TextEditingController occupationController,
      TextEditingController phoneController,
      TextEditingController emailController,
      TextEditingController numberOfMealsController,
      TextEditingController medicationAllergyController,
      TextEditingController takesSupplementController,
      TextEditingController supplementNameController,
      TextEditingController supplementDoseController,
      TextEditingController supplementReasonController,
      TextEditingController foodVariesWithMoodController,
      TextEditingController hasDietPlanController,
      TextEditingController consumesAlcoholController,
      TextEditingController smokesController,
      TextEditingController previousPhysicalActivityController,
      TextEditingController currentPhysicalActivityController,
      TextEditingController currentSportsInjuryDurationController,
      TextEditingController isPregnantController,
      TextEditingController diabetesController,
      TextEditingController dyslipidemiasController,
      TextEditingController obesityController,
      TextEditingController hypertensionController,
      TextEditingController cancerController,
      TextEditingController hypoHyperthyroidismController,
      TextEditingController otherConditionsController,
      TextEditingController weightController,
      TextEditingController heightController,
      TextEditingController neckCircumferenceController,
      TextEditingController waistCircumferenceController,
      TextEditingController hipCircumferenceController) async {
    try {
      completeNameController.text = completeName;
      birthDateController.text = convertDate(birthDate.toString());
      ageController.text = age.toString();
      genderController.text = gender == 'M' ? 'Masculino' : gender == 'F' ? 'Femenino' : '';
      maritalStatusController.text = maritalStatus;
      addressController.text = address;
      occupationController.text = occupation;
      phoneController.text = phone;
      emailController.text = email;
      numberOfMealsController.text = numberOfMeals.toString();
      medicationAllergyController.text = medicationAllergy;
      takesSupplementController.text = takesSupplement == true ? 'SI' : takesSupplement == false ? 'NO' : '';
      supplementNameController.text = supplementName;
      supplementDoseController.text = supplementDose;
      supplementReasonController.text = supplementReason;
      foodVariesWithMoodController.text = foodVariesWithMood == true ? 'SI' : foodVariesWithMood == false ? 'NO' : '';
      hasDietPlanController.text = hasDietPlan == true ? 'SI' : hasDietPlan == false ? 'NO' : '';
      consumesAlcoholController.text = consumesAlcohol == true ? 'SI' : consumesAlcohol == false ? 'NO' : '';
      smokesController.text = smokes == true ? 'SI' : smokes == false ? 'NO' : '';
      previousPhysicalActivityController.text =
          previousPhysicalActivity == true ? 'SI' : previousPhysicalActivity == false ? 'NO' : '';
      currentPhysicalActivityController.text = currentPhysicalInjury == true ? 'SI' : currentPhysicalInjury == false ? 'NO' : '';
      currentSportsInjuryDurationController.text = currentSportsInjuryDuration;
      isPregnantController.text = isPregnant == true ? 'SI' : isPregnant == false ? 'NO' : '';
      diabetesController.text = diabetes;
      dyslipidemiasController.text = dyslipidemias;
      obesityController.text = obesity;
      hypertensionController.text = hypertension;
      cancerController.text = cancer;
      hypoHyperthyroidismController.text = hypoHyperthyroidism;
      otherConditionsController.text = otherConditions;
      weightController.text = weight.toString();
      heightController.text = height.toString();
      neckCircumferenceController.text = neckCircumference.toString();
      waistCircumferenceController.text = waistCircumference.toString();
      hipCircumferenceController.text = hipCircumference.toString();
    } catch (e) {
      Logger.logAppError('Error al actualizar los controladores: $e');
    }
  }
}
