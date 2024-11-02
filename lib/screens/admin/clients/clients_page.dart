import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/controllers/client_classes_controller.dart';
import 'package:pilates/controllers/clients_controller.dart';
import 'package:pilates/helpers/launchers/maps_launcher.dart';
import 'package:pilates/models/response/all_client_class_response.dart';
import 'package:pilates/models/response/update_status_response.dart';
import 'package:pilates/models/send/update_status_send.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/theme/appbars/bottom_admin_bar.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  ClientsPageState createState() => ClientsPageState();
}

class ClientsPageState extends State<ClientsPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  TextFormFields textFormFields = TextFormFields();
  MapAppLauncher mapAppLauncher = MapAppLauncher();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  //Controlador
  final ClientClassesController clientClassesController =
      ClientClassesController();

  final LoginController loginController = LoginController();

  final TextEditingController searchController = TextEditingController();

  //Variables
  List<AllClientsPlansResponse> clients = [];
  List<AllClientsPlansResponse> allClients = []; // Nueva variable

  bool activeClients = true;
  bool isSearchMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getClients();
    });
    searchController.addListener(_onSearchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
  String query = searchController.text.toLowerCase();

  if (query.isEmpty) {
    // Si el campo de búsqueda está vacío, mostramos todos los clientes
    setState(() {
      clients = List.from(allClients);
    });
    return;
  }

  List<AllClientsPlansResponse> filteredClients = allClients.where((element) {
    String name = element.clientName.toLowerCase();
    String lastname = element.clientLastname.toLowerCase();
    String dni = element.clientDniNumber.toString();

    return name.contains(query) || lastname.contains(query) || dni.contains(query);
  }).toList();

  setState(() {
    clients = filteredClients;
  });
}


  void getClients() async {
  try {
    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    // Obtener los clientes desde el provider
    List<AllClientsPlansResponse> fetchedClients =
        clientClassProvider.allClientsPlansResponse ?? [];

    // Filtrar los clientes según su estado
    fetchedClients = activeClients
        ? fetchedClients
            .where((element) => element.statusClient == 'active')
            .toList()
        : fetchedClients
            .where((element) => element.statusClient == 'inactive')
            .toList();

    // Actualizar allClients y clients
    setState(() {
      allClients = fetchedClients; // Asigna la lista completa filtrada por estado
      clients = List.from(allClients); // Copia de allClients para mostrar
    });
  } catch (e) {
    // Manejo de errores
  }
}


  void updateClientStatus(int index, BuildContext context) async {
    bool status = clients[index].statusClient == 'active' ? false : true;
    String statusString = status == true ? 'active' : 'inactive';

    UpdateStatusSend updateStatusSend =
        UpdateStatusSend(statusClient: statusString);

    // Cambiar el estado del cliente
    UpdateStatusResponse response = await loginController.updateStatusClient(
      updateStatusSend,
      clients[index].clientDniNumber,
    );

    if (response.message
        .contains('Estado del cliente actualizado correctamente')) {
      setState(() {
        clients[index].statusClient = statusString;
        // Si se cambió el estado a activo, actualizamos activeClients
        activeClients = statusString == 'active';
      });

      String newStatus = status == true ? 'activo' : 'inactivo';
      Future.microtask(() => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                  text: 'El estado del cliente ha cambiado a: $newStatus',
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 4 * SizeConfig.widthMultiplier,
                  color: ColorsPalette.white,
                ),
                backgroundColor: ColorsPalette.greenAged,
                duration: const Duration(seconds: 1),
              ),
            )
          });
    } else {
      Future.microtask(() => {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                  text: response.message,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 4 * SizeConfig.widthMultiplier,
                  color: ColorsPalette.white,
                ),
                backgroundColor: ColorsPalette.redAged,
                duration: const Duration(seconds: 1),
              ),
            )
          });
    }

    log('El estado del cliente ha cambiado a: $status');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.greyChocolate),
      body: Container(
        color: ColorsPalette.greyChocolate,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.widthMultiplier,
                  vertical: 1 * SizeConfig.heightMultiplier),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 8 * SizeConfig.imageSizeMultiplier,
                    backgroundColor: ColorsPalette.white,
                    child: Icon(
                      FontAwesomeIcons.user,
                      size: 8 * SizeConfig.imageSizeMultiplier,
                      color: ColorsPalette.black,
                    ),
                  ),
                  SizedBox(
                    width: 5 * SizeConfig.widthMultiplier,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      texts.normalText(
                          text: 'Clientes',
                          color: ColorsPalette.white,
                          fontSize: 4 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                      texts.normalText(
                          text: 'Revisa el estado de tus clientes',
                          color: ColorsPalette.white,
                          fontSize: 2 * SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w400),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            isSearchMode
                ? SizedBox(
                    width: 95 * SizeConfig.widthMultiplier,
                    height: 10 * SizeConfig.heightMultiplier,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80 * SizeConfig.widthMultiplier,
                          child: textFormFields.create(
                            controller: searchController,
                            title: 'Buscar cliente',
                            hintText: 'Nombre, apellido o cédula',
                            fillColor: ColorsPalette.white,
                            typeTextField: TextFieldType.alphanumeric,
                            labelcolor: ColorsPalette.black,
                          ),
                        ),
                        SizedBox(
                          width: 2 * SizeConfig.widthMultiplier,
                        ),
                        Container(
                          width: 10 * SizeConfig.widthMultiplier,
                          height: 10 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                            color: ColorsPalette.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearchMode = !isSearchMode;
                                searchController.clear();
                              });
                            },
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: ColorsPalette.white,
                              size: 6 * SizeConfig.imageSizeMultiplier,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsPalette.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 95 * SizeConfig.widthMultiplier,
                        height: 10 * SizeConfig.heightMultiplier,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Alinea los elementos al inicio
                          children: [
                            SizedBox(
                              width: 35 * SizeConfig.widthMultiplier,
                              child: buttons.iconTextUnderline(
                                icon: FontAwesomeIcons.circleCheck,
                                text: 'Activos',
                                onPressed: () {
                                  setState(() {
                                    activeClients = true;
                                    searchController.clear();
                                    getClients();
                                  });
                                },
                                color: activeClients == false
                                    ? ColorsPalette.white
                                    : ColorsPalette.gold,
                              ),
                            ),
                            SizedBox(
                              width: 35 * SizeConfig.widthMultiplier,
                              child: buttons.iconTextUnderline(
                                icon: FontAwesomeIcons.circleXmark,
                                text: 'Inactivos',
                                onPressed: () {
                                  setState(() {
                                    activeClients = false;
                                    searchController.clear();
                                    getClients();
                                  });
                                },
                                color: activeClients == false
                                    ? ColorsPalette.gold
                                    : ColorsPalette.white,
                              ),
                            ),
                            SizedBox(
                              width: 3.5 * SizeConfig.widthMultiplier,
                            ),
                            Container(
                              width: 0.25 * SizeConfig.widthMultiplier,
                              height: 4 * SizeConfig.heightMultiplier,
                              color: ColorsPalette.white,
                            ),
                            SizedBox(
                              width: 2.75 * SizeConfig.widthMultiplier,
                            ),
                            SizedBox(
                              width: 15 * SizeConfig.widthMultiplier,
                              child: GestureDetector(
                                child: Icon(
                                  FontAwesomeIcons.magnifyingGlassChart,
                                  color: ColorsPalette.white,
                                  size: 6.5 * SizeConfig.imageSizeMultiplier,
                                ),
                                onTap: () {
                                  setState(() {
                                    isSearchMode = !isSearchMode;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Flexible(
              child: Container(
                width: 100 * SizeConfig.widthMultiplier,
                padding: EdgeInsets.symmetric(
                    horizontal: 5 * SizeConfig.widthMultiplier,
                    vertical: 2 * SizeConfig.heightMultiplier),
                decoration: const BoxDecoration(
                    color: ColorsPalette.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: clients.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            activeClients == true
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circleXmark,
                            size: 20 * SizeConfig.imageSizeMultiplier,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                            text: activeClients == true
                                ? 'No dispones de clientes activos'
                                : 'No dispones de clientes inactivos',
                            color: ColorsPalette.black,
                            fontSize: 3 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: clients.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 5 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                    text:
                                        '${clients[index].clientName} ${clients[index].clientLastname}',
                                    color: ColorsPalette.black,
                                    fontSize: 2.5 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    width: 4 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                    text: clients[index]
                                        .clientDniNumber
                                        .toString(),
                                    color: ColorsPalette.greenAged,
                                    fontSize: 1.7 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    5 * SizeConfig.widthMultiplier,
                                    2 * SizeConfig.heightMultiplier,
                                    0,
                                    2 * SizeConfig.heightMultiplier),
                                width: 90 * SizeConfig.widthMultiplier,
                                height: 20 * SizeConfig.heightMultiplier,
                                decoration: BoxDecoration(
                                    color: ColorsPalette.white,
                                    border: Border.all(
                                      color:
                                          ColorsPalette.beige.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorsPalette.black
                                            .withOpacity(0.1),
                                        spreadRadius: 5,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50 * SizeConfig.widthMultiplier,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          texts.normalText(
                                              text: 'Información',
                                              color: ColorsPalette.black,
                                              fontSize: 2.5 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w600),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text:
                                                  'Celular: ${clients[index].clientPhone}',
                                              color: ColorsPalette.greyAged,
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text: clients[index]
                                                      .paymentMethod
                                                      .contains('bank transfer')
                                                  ? 'Pago: Tranferencia'
                                                  : 'Pago: Efectivo',
                                              color: ColorsPalette.greyAged,
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start),
                                          SizedBox(
                                            height: 0.5 *
                                                SizeConfig.heightMultiplier,
                                          ),
                                          texts.normalText(
                                              text:
                                                  'Plan: ${clients[index].planDescription}',
                                              color: ColorsPalette.greyAged,
                                              fontSize: 2 *
                                                  SizeConfig.heightMultiplier,
                                              fontWeight: FontWeight.w400,
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2 * SizeConfig.widthMultiplier,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width:
                                                10 * SizeConfig.widthMultiplier,
                                            height:
                                                10 * SizeConfig.widthMultiplier,
                                            decoration: BoxDecoration(
                                                color: ColorsPalette.chocolate,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            padding: EdgeInsets.all(
                                                2 * SizeConfig.widthMultiplier),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons
                                                      .fileInvoiceDollar,
                                                  color: ColorsPalette.white,
                                                  size: 4 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              2 * SizeConfig.heightMultiplier,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width:
                                                10 * SizeConfig.widthMultiplier,
                                            height:
                                                10 * SizeConfig.widthMultiplier,
                                            decoration: BoxDecoration(
                                                color: ColorsPalette.greyAged,
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            padding: EdgeInsets.all(
                                                2 * SizeConfig.widthMultiplier),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.key,
                                                  color: ColorsPalette.white,
                                                  size: 4 *
                                                      SizeConfig
                                                          .imageSizeMultiplier,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Agregar letras en direccion vertical con el status de la clase
                                    Transform.rotate(
                                      angle: -3.14 / 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          updateClientStatus(index, context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                clients[index].statusClient ==
                                                        'active'
                                                    ? ColorsPalette.greenAged
                                                    : ColorsPalette.redAged,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2 *
                                                  SizeConfig.widthMultiplier,
                                              horizontal: 2 *
                                                  SizeConfig.widthMultiplier),
                                          child: texts.normalText(
                                            text: clients[index].statusClient ==
                                                    'active'
                                                ? 'Activo'
                                                : 'Inactivo',
                                            color: ColorsPalette.white,
                                            fontSize:
                                                4 * SizeConfig.widthMultiplier,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2 * SizeConfig.heightMultiplier,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAdminBar(),
    );
  }
}
