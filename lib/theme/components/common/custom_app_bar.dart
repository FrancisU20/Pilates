import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_search_delegate.dart';
import 'package:provider/provider.dart';

class CustomAppBar<T> extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final List<T>? data; // Lista genérica de datos
  final String Function(T)? searchField; // Función para obtener el campo a buscar

  const CustomAppBar({
    super.key,
    this.backgroundColor = AppColors.white100,
    this.data,
    this.searchField,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft,
              color: backgroundColor == AppColors.white100
                  ? AppColors.black100
                  : AppColors.white100),
          onPressed: () async {
            LoginProvider loginProvider =
                Provider.of<LoginProvider>(context, listen: false);

            if (loginProvider.user == null) {
              context.pop();
            } else if (loginProvider.user!.role == 'admin') {
              await AppMiddleware.updateAdminData(context, '/admin-dashboard');
            } else {
              await AppMiddleware.updateClientData(context, '/dashboard');
            }
          },
        ),
      ),
      actions: [
        // Mostrar la acción solo si se pasa `data` y `searchField`
        if (data != null && searchField != null)
          IconButton(
            icon: Icon(FontAwesomeIcons.magnifyingGlass,
                color: backgroundColor == AppColors.white100
                    ? AppColors.black100
                    : AppColors.white100),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate<T>(
                  data: data!, // Pasa la lista genérica
                  searchField: searchField!, // Pasa la función de campo a buscar
                ),
              );
            },
          ),
      ],
    );
  }
}
