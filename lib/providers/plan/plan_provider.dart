import 'package:flutter/material.dart';
import 'package:pilates/controllers/plan/plan_controller.dart';
import 'package:pilates/models/common/standard_response.dart';
import 'package:pilates/models/plan/plan_model.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';

class PlanProvider extends ChangeNotifier {
  //****************************************/
  //? Controllers
  final PlanController planController = PlanController();

  //? Packages

  //****************************************/
  //? Variables

  //? Setters Variables

  //****************************************/
  //? Objetos

  //? Setters Objetos

  //****************************************/
  //? Listas
  List<PlanModel> plans = [];

  //? Setters Listas
  void setListPlans(List<PlanModel> plans) {
    this.plans = plans;
    notifyListeners();
  }

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
  //? Obtener planes
  Future<void> getPlans(BuildContext context) async {
    try {
      showLoading();

      StandardResponse<List<PlanModel>> responsePlans =
          await planController.getPlans();

      if (!context.mounted) return;

      setListPlans(responsePlans.data!);

      CustomSnackBar.show(
        context,
        responsePlans.message,
        SnackBarType.success,
      );
    } catch (e) {
      CustomSnackBar.show(
        context,
        e.toString(),
        SnackBarType.error,
      );
    } finally {
      hideLoading();
    }
  }
}
