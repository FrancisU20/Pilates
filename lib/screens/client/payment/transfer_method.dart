import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/controllers/client_plans_controller.dart';
import 'package:pilates/controllers/clients_controller.dart';
import 'package:pilates/controllers/file_manager_controller.dart';
import 'package:pilates/models/response/create_client_plan_response.dart';
import 'package:pilates/models/response/create_client_response.dart';
import 'package:pilates/models/response/upload_profile_photo_response.dart';
import 'package:pilates/models/send/create_client_plan_send.dart';
import 'package:pilates/models/send/create_client_send.dart';
import 'package:pilates/providers/client_class_provider.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/appbars/custom_appbar.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/loading_modal.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

class TransferMethodPage extends StatefulWidget {
  const TransferMethodPage({super.key});

  @override
  TransferMethodPageState createState() => TransferMethodPageState();
}

class TransferMethodPageState extends State<TransferMethodPage> {
  Texts texts = Texts();
  Buttons buttons = Buttons();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  //Controladores
  ClientPlansController clientPlansController = ClientPlansController();
  LoginController loginController = LoginController();
  FileManagerController fileManagerController = FileManagerController();

  // Modals
  final LoadingModal loadingModal = LoadingModal();

  @override
  void initState() {
    super.initState();
  }

  String convertDate(String date) {
    String year = date.substring(0, 4);
    String month = date.substring(5, 7);
    String day = date.substring(8, 10);

    // La fecah debe mostrarse como Miércoles 12 de Mayo de 2021
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
    }

    return '$day de $monthName de $year';
  }

  Future<void> _pickImage(ImageSource source) async {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    loadingModal.showLoadingModal(context);
    final XFile? selected = await _picker.pickImage(source: source);

    if (selected == null) {
      Future.microtask(() {
        loadingModal.closeLoadingModal(context);
      });
      return;
    } else {
      try {
        UploadS3Response uploadProfilePhotoResponse =
            await fileManagerController.postS3TransferVoucher(
                selected, registerProvider.dni!);
        log(uploadProfilePhotoResponse.fileUrl);
        registerProvider.setTransferImageFile(selected);
        registerProvider
            .setTransferImageUrl(uploadProfilePhotoResponse.fileUrl);

        Future.microtask(() {
          loadingModal.closeLoadingModal(context);
        });

        setState(() {
          _imageFile = selected;
        });
      } catch (e) {
        log(e.toString());
        setState(() {
          _imageFile = null;
        });
        registerProvider.clearTransferImageFile();
        registerProvider.clearTransferImageUrl();

        Future.microtask(() {
          loadingModal.closeLoadingModal(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: texts.normalText(
                  text: e.toString().replaceAll('Exception: ', ''),
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 4 * SizeConfig.heightMultiplier,
                  color: ColorsPalette.white),
              backgroundColor: ColorsPalette.redAged,
            ),
          );
        });
      }
    }
  }

  Future<void> createRegister() async {
    try {
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      RegisterProvider registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);

      CreateClientSend createClientObject = CreateClientSend(
          dniType: 'CED',
          dniNumber: registerProvider.dni!,
          name: registerProvider.name!,
          lastname: registerProvider.lastname!,
          password: registerProvider.password!,
          birthdate: registerProvider.birthday!,
          phone: registerProvider.phone!,
          gender: registerProvider.gender!.toLowerCase(),
          photo: registerProvider.imageUrl!,
          email: registerProvider.email!,
          statusClient: 'inactive');

      CreateClientResponse createClientResponse =
          await loginController.postClient(createClientObject);

      if (createClientResponse.message == 'Cliente creado correctamente') {
        DateTime now = DateTime.now();

        DateTime planvigency = now;
        DateTime planexpiration = now
            .add(Duration(days: registerProvider.selectedPlan!.classVigency));

        CreateClientPlanSend createClientPlanObject = CreateClientPlanSend(
          clientId: createClientResponse.data.id,
          planId: registerProvider.selectedPlan!.id,
          planVigency: planvigency,
          planExpiration: planexpiration,
          attendedClasses: 0,
          status: 'active',
          paymentMethod: 'bank transfer',
          paymentToken: registerProvider.transferImageUrl!,
        );

        // Crear el plan del cliente
        CreateClientPlanResponse createClientPlanResponse =
            await clientPlansController
                .createClientPlan(createClientPlanObject);

        // Actualizar el estado con los nuevos datos y cerrar el modal de carga
        if (createClientPlanResponse.message
            .contains('Plan del cliente creado exitosamente')) {
          Future.microtask(() => {
                loadingModal.closeLoadingModal(context),
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 5),
                    content: texts.normalText(
                        text: 'Tu cuenta ha sido creada exitosamente',
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        fontSize: 4 * SizeConfig.heightMultiplier,
                        color: ColorsPalette.white),
                    backgroundColor: ColorsPalette.greenAged,
                  ),
                ),
              });
        }
      } else {
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: texts.normalText(
                      text:
                          'El cliente ya se encuentra registrado verifique el email y el número de cédula ingresados.',
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      color: ColorsPalette.white),
                  backgroundColor: ColorsPalette.redAged,
                ),
              ),
            });
      }
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 4 * SizeConfig.heightMultiplier,
                    color: ColorsPalette.white),
                backgroundColor: ColorsPalette.redAged,
              ),
            ),
          });
    }
  }

  Future<void> renewRegister() async {
    try {
      // Mostrar el modal de carga
      Future.microtask(() => {loadingModal.showLoadingModal(context)});

      ClientClassProvider clientClassesProvider =
          Provider.of<ClientClassProvider>(context, listen: false);

      RegisterProvider registerProvider =
          Provider.of<RegisterProvider>(context, listen: false);

      DateTime now = DateTime.now();

      DateTime planvigency = now;
      DateTime planexpiration =
          now.add(Duration(days: registerProvider.selectedPlan!.classVigency));

      CreateClientPlanSend createClientPlanObject = CreateClientPlanSend(
          clientId: clientClassesProvider.loginResponse!.client.id,
          planId: registerProvider.selectedPlan!.id,
          planVigency: planvigency,
          planExpiration: planexpiration,
          attendedClasses: 0,
          paymentMethod: 'bank transfer',
          paymentToken: registerProvider.transferImageUrl!,
          status: 'active');

      // Crear la clase de pilates
      CreateClientPlanResponse createClientClassResponse =
          await clientPlansController.createClientPlan(createClientPlanObject);

      // Actualizar el estado con los nuevos datos y cerrar el modal de carga
      if (createClientClassResponse.message
          .contains('Plan del cliente creado exitosamente')) {
        Future.microtask(() => {
              loadingModal.closeLoadingModal(context),
              Navigator.pushNamedAndRemoveUntil(
                  context, '/dashboard', (route) => false),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 5),
                  content: texts.normalText(
                      text: 'Tu plan ha sido renovado exitosamente',
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      fontSize: 4 * SizeConfig.heightMultiplier,
                      color: ColorsPalette.white),
                  backgroundColor: ColorsPalette.greenAged,
                ),
              ),
            });
      }
    } catch (e) {
      log('Error: $e');
      Future.microtask(() => {
            loadingModal.closeLoadingModal(context),
            loadingModal.closeLoadingModal(context),
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: texts.normalText(
                    text: e.toString().replaceAll('Exception: ', ''),
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                    fontSize: 4 * SizeConfig.heightMultiplier,
                    color: ColorsPalette.white),
                backgroundColor: ColorsPalette.redAged,
              ),
            ),
          });
    }
  }

  void determinateCreateOrRenew() async {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    if (registerProvider.dni != null) {
      // Crear el registro
      await createRegister();
    } else {
      // Renovar el registro
      await renewRegister();
    }
  }

  void showCreateConfirmModal() {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: ColorsPalette.white,
            title: texts.normalText(
              text: registerProvider.dni != null
                  ? 'Confirmar Registro'
                  : 'Confirmar Renovación',
              color: ColorsPalette.black,
              fontSize: 2.5 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
            content: SizedBox(
              width: 100 * SizeConfig.widthMultiplier,
              height: 28 * SizeConfig.heightMultiplier,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logotipo de Curves
                  Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 20 * SizeConfig.heightMultiplier,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo/logo_rectangle.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 60 * SizeConfig.widthMultiplier,
                      height: 8 * SizeConfig.heightMultiplier,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          texts.normalText(
                            text: registerProvider.dni != null
                                ? '¿Estás seguro de querer registrarte con estos datos?'
                                : '¿Estás seguro de querer renovar tu plan ?',
                            color: ColorsPalette.black,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: texts.normalText(
                  text: 'No',
                  color: ColorsPalette.greyChocolate,
                  fontSize: 2 * SizeConfig.heightMultiplier,
                  fontWeight: FontWeight.w500,
                ),
              ),
              buttons.standart(
                text: 'Sí',
                color: ColorsPalette.greyChocolate,
                width: 6 * SizeConfig.widthMultiplier,
                onPressed: () {
                  determinateCreateOrRenew();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    ClientClassProvider clientClassProvider =
        Provider.of<ClientClassProvider>(context, listen: false);

    DateTime now = DateTime.now();
    DateTime planvigency = now;
    DateTime planexpiration =
        now.add(Duration(days: registerProvider.selectedPlan!.classVigency));
    return Scaffold(
      appBar: const CustomAppBar(backgroundColor: ColorsPalette.greyChocolate),
      body: Stack(children: [
        Container(
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
                        FontAwesomeIcons.moneyBill,
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
                            text: 'Checkout',
                            color: ColorsPalette.white,
                            fontSize: 4 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400),
                        texts.normalText(
                            text: 'Estás a un paso de comenzar',
                            color: ColorsPalette.white,
                            fontSize: 2 * SizeConfig.heightMultiplier,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.left),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2 * SizeConfig.heightMultiplier,
              ),
              Flexible(
                child: Container(
                    width: 100 * SizeConfig.widthMultiplier,
                    height: 78 * SizeConfig.heightMultiplier,
                    padding: EdgeInsets.symmetric(
                        horizontal: 5 * SizeConfig.widthMultiplier,
                        vertical: 2 * SizeConfig.heightMultiplier),
                    decoration: const BoxDecoration(
                        color: ColorsPalette.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: texts.normalText(
                                text: registerProvider.dni != null
                                    ? 'Tu credencial esta lista'
                                    : 'Tu credencial está renovandose',
                                color: ColorsPalette.black,
                                fontSize: 2.5 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Container(
                            width: 100 * SizeConfig.widthMultiplier,
                            height: 50 * SizeConfig.widthMultiplier,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5 * SizeConfig.widthMultiplier,
                                vertical: 2 * SizeConfig.heightMultiplier),
                            decoration: BoxDecoration(
                                color: ColorsPalette.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 20 * SizeConfig.widthMultiplier,
                                      height: 30 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                        color: ColorsPalette.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            registerProvider.imageFile != null
                                                ? Image.file(
                                                    File(registerProvider
                                                        .imageFile!.path),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    clientClassProvider
                                                        .loginResponse!
                                                        .client
                                                        .photo,
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5 * SizeConfig.widthMultiplier,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 20 *
                                                  SizeConfig.widthMultiplier,
                                              height: 10 *
                                                  SizeConfig.widthMultiplier,
                                              decoration: BoxDecoration(
                                                color: ColorsPalette.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/logo/logo_rectangle.png',
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        texts.normalText(
                                            text: registerProvider.name != null
                                                ? '${registerProvider.name} ${registerProvider.lastname}'
                                                : '${clientClassProvider.loginResponse!.client.name} ${clientClassProvider.loginResponse!.client.lastname}',
                                            color: ColorsPalette.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text: registerProvider.dni != null
                                                ? registerProvider.dni!
                                                : clientClassProvider
                                                    .loginResponse!
                                                    .client
                                                    .dniNumber,
                                            color: ColorsPalette.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text: registerProvider.phone != null
                                                ? 'Celular: ${registerProvider.phone!.replaceAll('+593', '0')}'
                                                : 'Celular: ${clientClassProvider.loginResponse!.client.phone.replaceAll('+593', '0')}',
                                            color: ColorsPalette.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                        texts.normalText(
                                            text: registerProvider.birthday !=
                                                    null
                                                ? 'Cumpleaños: ${registerProvider.birthday.toString().substring(0, 10)}'
                                                : 'Cumpleaños: ${clientClassProvider.loginResponse!.client.birthdate.toString().substring(0, 10)}',
                                            color: ColorsPalette.white,
                                            fontSize: 1.6 *
                                                SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w500),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.heightMultiplier,
                                ),
                                texts.normalText(
                                    text: registerProvider.dni != null
                                        ? 'Miembro desde el ${convertDate(DateTime.now().toString().substring(0, 10))}'
                                        : 'Miembro desde el ${convertDate(clientClassProvider.loginResponse!.client.createdAt.toString().substring(0, 10))}',
                                    color: ColorsPalette.white,
                                    fontSize: 1.6 * SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          texts.normalText(
                              text: 'Datos del plan contratado:',
                              color: ColorsPalette.black,
                              fontSize: 2.5 * SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Plan:',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '${registerProvider.selectedPlan!.name} - ${registerProvider.selectedPlan!.description}',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Vigencia desde:',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: convertDate(planvigency
                                          .toString()
                                          .substring(0, 10)),
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Vigencia hasta:',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text: convertDate(planexpiration
                                          .toString()
                                          .substring(0, 10)),
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                              Row(
                                children: [
                                  texts.normalText(
                                      text: 'Precio:',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w600),
                                  SizedBox(
                                    width: 2 * SizeConfig.widthMultiplier,
                                  ),
                                  texts.normalText(
                                      text:
                                          '\$ ${registerProvider.selectedPlan!.price.toStringAsFixed(2)}',
                                      color: ColorsPalette.black,
                                      fontSize: 2 * SizeConfig.heightMultiplier,
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.5 * SizeConfig.heightMultiplier,
                          ),
                          Visibility(
                            visible: _imageFile == null,
                            child: SizedBox(
                                width: 100 * SizeConfig.widthMultiplier,
                                child: Column(
                                  children: [
                                    texts.normalText(
                                        text: 'Datos de la cuenta:',
                                        color: ColorsPalette.black,
                                        fontSize:
                                            2.5 * SizeConfig.heightMultiplier,
                                        fontWeight: FontWeight.w400),
                                    SizedBox(
                                      height: 2 * SizeConfig.heightMultiplier,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Banco:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            texts.normalText(
                                                text:
                                                    'Produbanco Cuenta de Corriente',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Cuenta:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Copiar al portapapeles
                                                Clipboard.setData(
                                                    const ClipboardData(
                                                        text: '02005333063'));

                                                // Mostrar un SnackBar o algún otro indicador para confirmar que se copió
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: texts.normalText(
                                                        text:
                                                            'Cuenta copiada al portapapeles',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontSize: 4 *
                                                            SizeConfig
                                                                .heightMultiplier,
                                                        color: ColorsPalette
                                                            .white),
                                                    backgroundColor:
                                                        ColorsPalette.black,
                                                  ),
                                                );
                                              },
                                              child: texts.normalText(
                                                  text: '02005333063',
                                                  color: ColorsPalette.black,
                                                  fontSize: 2 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Razón Social:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            texts.normalText(
                                                text: 'Curve Experienc S.A.S.',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Identificación:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Copiar al portapapeles
                                                Clipboard.setData(
                                                    const ClipboardData(
                                                        text: '1091798469001'));

                                                // Mostrar un SnackBar o algún otro indicador para confirmar que se copió
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: texts.normalText(
                                                        text: 'RUC copiado al portapapeles',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontSize: 4 *
                                                            SizeConfig
                                                                .heightMultiplier,
                                                        color: ColorsPalette
                                                            .white),
                                                    backgroundColor:
                                                        ColorsPalette.black,
                                                  ),
                                                );
                                              },
                                              child: texts.normalText(
                                                text: '1091798469001',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Teléfono:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            texts.normalText(
                                                text: '0958983470',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              1 * SizeConfig.heightMultiplier,
                                        ),
                                        Row(
                                          children: [
                                            texts.normalText(
                                                text: 'Email:',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w600),
                                            SizedBox(
                                              width: 2 *
                                                  SizeConfig.widthMultiplier,
                                            ),
                                            texts.normalText(
                                                text:
                                                    'curvexperiencegomlop@gmail.com',
                                                color: ColorsPalette.black,
                                                fontSize: 2 *
                                                    SizeConfig.heightMultiplier,
                                                fontWeight: FontWeight.w400),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 2 * SizeConfig.heightMultiplier,
                          ),
                          Center(
                            child: _imageFile == null
                                ? const SizedBox.shrink()
                                : Center(
                                    child: texts.normalText(
                                        text: 'Comprobante adjuntado',
                                        color: ColorsPalette.greenAged,
                                        fontSize:
                                            3 * SizeConfig.heightMultiplier,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center),
                                  ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ]),
      floatingActionButton: _imageFile != null
          ? FloatingActionButton(
              onPressed: () {
                showCreateConfirmModal();
              },
              backgroundColor: ColorsPalette.greenAged,
              child: const Icon(
                FontAwesomeIcons.check,
                color: ColorsPalette.white,
              ),
            )
          : FloatingActionButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              backgroundColor: ColorsPalette.beigeAged,
              child: const Icon(
                FontAwesomeIcons.camera,
                color: ColorsPalette.white,
              ),
            ),
    );
  }
}
