import 'dart:convert';

/// Modelo para la información nutricional
NutritionalDataModel nutritionalDataModelFromJson(String str) =>
    NutritionalDataModel.fromJson(json.decode(str));

String nutritionalDataModelToJson(NutritionalDataModel data) =>
    json.encode(data.toJson());

class NutritionalDataModel {
  final PersonalInformation? personalInformation;
  final EatingHabits? eatingHabits;
  final DiseasesInformation? diseasesInformation;
  final AnthropometricData? anthropometricData;

  NutritionalDataModel({
    this.personalInformation,
    this.eatingHabits,
    this.diseasesInformation,
    this.anthropometricData,
  });

  factory NutritionalDataModel.fromJson(Map<String, dynamic> json) =>
      NutritionalDataModel(
        personalInformation: json["personalInformation"] != null
            ? PersonalInformation.fromJson(json["personalInformation"])
            : null,
        eatingHabits: json["eatingHabits"] != null
            ? EatingHabits.fromJson(json["eatingHabits"])
            : null,
        diseasesInformation: json["diseasesInformation"] != null
            ? DiseasesInformation.fromJson(json["diseasesInformation"])
            : null,
        anthropometricData: json["anthropometricData"] != null
            ? AnthropometricData.fromJson(json["anthropometricData"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (personalInformation != null)
          "personalInformation": personalInformation!.toJson(),
        if (eatingHabits != null) "eatingHabits": eatingHabits!.toJson(),
        if (diseasesInformation != null)
          "diseasesInformation": diseasesInformation!.toJson(),
        if (anthropometricData != null)
          "anthropometricData": anthropometricData!.toJson(),
      };
}

/// Modelo para la información personal
class PersonalInformation {
  final String? completeName;
  final String? birthDate;
  final int? age;
  final String? gender;
  final String? maritalStatus;
  final String? address;
  final String? occupation;
  final String? phone;
  final String? email;

  PersonalInformation({
    this.completeName,
    this.birthDate,
    this.age,
    this.gender,
    this.maritalStatus,
    this.address,
    this.occupation,
    this.phone,
    this.email,
  });

  factory PersonalInformation.fromJson(Map<String, dynamic> json) =>
      PersonalInformation(
        completeName: json["completeName"],
        birthDate: json["birthDate"],
        age: json["age"],
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        address: json["address"],
        occupation: json["occupation"],
        phone: json["phone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        if (completeName != null) "completeName": completeName,
        if (birthDate != null) "birthDate": birthDate,
        if (age != null) "age": age,
        if (gender != null) "gender": gender,
        if (maritalStatus != null) "maritalStatus": maritalStatus,
        if (address != null) "address": address,
        if (occupation != null) "occupation": occupation,
        if (phone != null) "phone": phone,
        if (email != null) "email": email,
      };
}

/// Modelo para los hábitos alimenticios
class EatingHabits {
  final int? numberOfMeals;
  final String? medicationAllergy;
  final bool? takesSupplement;
  final String? supplementName;
  final String? supplementDose;
  final String? supplementReason;
  final bool? foodVariesWithMood;
  final bool? hasDietPlan;
  final bool? consumesAlcohol;
  final bool? smokes;
  final bool? previousPhysicalActivity;
  final bool? isPregnant;
  final bool? currentPhysicalInjury;
  final String? currentSportsInjuryDuration;

  EatingHabits({
    this.numberOfMeals,
    this.medicationAllergy,
    this.takesSupplement,
    this.supplementName,
    this.supplementDose,
    this.supplementReason,
    this.foodVariesWithMood,
    this.hasDietPlan,
    this.consumesAlcohol,
    this.smokes,
    this.previousPhysicalActivity,
    this.isPregnant,
    this.currentPhysicalInjury,
    this.currentSportsInjuryDuration,
  });

  factory EatingHabits.fromJson(Map<String, dynamic> json) => EatingHabits(
        numberOfMeals: json["numberOfMeals"],
        medicationAllergy: json["medicationAllergy"],
        takesSupplement: json["takesSupplement"],
        supplementName: json["supplementName"],
        supplementDose: json["supplementDose"],
        supplementReason: json["supplementReason"],
        foodVariesWithMood: json["foodVariesWithMood"],
        hasDietPlan: json["hasDietPlan"],
        consumesAlcohol: json["consumesAlcohol"],
        smokes: json["smokes"],
        previousPhysicalActivity: json["previousPhysicalActivity"],
        isPregnant: json["isPregnant"],
        currentPhysicalInjury: json["currentPhysicalInjury"],
        currentSportsInjuryDuration: json["currentSportsInjuryDuration"],
      );

  Map<String, dynamic> toJson() => {
        if (numberOfMeals != null) "numberOfMeals": numberOfMeals,
        if (medicationAllergy != null) "medicationAllergy": medicationAllergy,
        if (takesSupplement != null) "takesSupplement": takesSupplement,
        if (supplementName != null) "supplementName": supplementName,
        if (supplementDose != null) "supplementDose": supplementDose,
        if (supplementReason != null) "supplementReason": supplementReason,
        if (foodVariesWithMood != null)
          "foodVariesWithMood": foodVariesWithMood,
        if (hasDietPlan != null) "hasDietPlan": hasDietPlan,
        if (consumesAlcohol != null) "consumesAlcohol": consumesAlcohol,
        if (smokes != null) "smokes": smokes,
        if (previousPhysicalActivity != null)
          "previousPhysicalActivity": previousPhysicalActivity,
        if (isPregnant != null) "isPregnant": isPregnant,
        if (currentPhysicalInjury != null)
          "currentPhysicalInjury": currentPhysicalInjury,
        if (currentSportsInjuryDuration != null)
          "currentSportsInjuryDuration": currentSportsInjuryDuration,
      };
}

/// Modelo para la información de enfermedades
class DiseasesInformation {
  final String? diabetes;
  final String? dyslipidemias;
  final String? obesity;
  final String? hypertension;
  final String? cancer;
  final String? hypoHyperthyroidism;
  final String? otherConditions;

  DiseasesInformation({
    this.diabetes,
    this.dyslipidemias,
    this.obesity,
    this.hypertension,
    this.cancer,
    this.hypoHyperthyroidism,
    this.otherConditions,
  });

  factory DiseasesInformation.fromJson(Map<String, dynamic> json) =>
      DiseasesInformation(
        diabetes: json["diabetes"],
        dyslipidemias: json["dyslipidemias"],
        obesity: json["obesity"],
        hypertension: json["hypertension"],
        cancer: json["cancer"],
        hypoHyperthyroidism: json["hypoHyperthyroidism"],
        otherConditions: json["otherConditions"],
      );

  Map<String, dynamic> toJson() => {
        if (diabetes != null) "diabetes": diabetes,
        if (dyslipidemias != null) "dyslipidemias": dyslipidemias,
        if (obesity != null) "obesity": obesity,
        if (hypertension != null) "hypertension": hypertension,
        if (cancer != null) "cancer": cancer,
        if (hypoHyperthyroidism != null)
          "hypoHyperthyroidism": hypoHyperthyroidism,
        if (otherConditions != null) "otherConditions": otherConditions,
      };
}

/// Modelo para los datos antropométricos
class AnthropometricData {
  final double? weight;
  final double? height;
  final double? neckCircumference;
  final double? waistCircumference;
  final double? hipCircumference;

  AnthropometricData({
    this.weight,
    this.height,
    this.neckCircumference,
    this.waistCircumference,
    this.hipCircumference,
  });

  factory AnthropometricData.fromJson(Map<String, dynamic> json) =>
      AnthropometricData(
        weight: json["weight"],
        height: json["height"],
        neckCircumference: json["neckCircumference"],
        waistCircumference: json["waistCircumference"],
        hipCircumference: json["hipCircumference"],
      );

  Map<String, dynamic> toJson() => {
        if (weight != null) "weight": weight,
        if (height != null) "height": height,
        if (neckCircumference != null) "neckCircumference": neckCircumference,
        if (waistCircumference != null)
          "waistCircumference": waistCircumference,
        if (hipCircumference != null) "hipCircumference": hipCircumference,
      };
}
