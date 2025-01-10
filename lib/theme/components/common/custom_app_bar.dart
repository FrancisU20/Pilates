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
  final List Function(T)?
      dataExtractor; //! Función para extraer datos del provider
  final String Function(dynamic)?
      searchField; //! Función para buscar dentro de los datos
  final void Function(dynamic)? onTap; //! Función para ejecutar al hacer tap

  const CustomAppBar({
    super.key,
    this.backgroundColor = AppColors.white100,
    this.dataExtractor,
    this.searchField,
    this.onTap,
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
        Consumer<T>(
          builder: (context, provider, child) {
            final data = dataExtractor?.call(provider) ?? [];
            return IconButton(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: backgroundColor == AppColors.white100
                    ? AppColors.black100
                    : AppColors.white100,
              ),
              onPressed: data.isNotEmpty
                  ? () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate<dynamic>(
                          data: data,
                          searchField: searchField!,
                          onTap: onTap!, 
                        ),
                      );
                    }
                  : null,
            );
          },
        ),
      ],
    );
  }
}
