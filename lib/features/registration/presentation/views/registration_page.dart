import 'package:banco_tiempo_app/cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/registration/domain/registration_form_entity.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:flutter/gestures.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text("Registrate"),
          centerTitle: true,
        ),
        body: RegisterBody());
  }
}

//TODO: missing upload images because API is unclear.

class RegisterBody extends StatefulWidget {
  //final List<Categoria> categories;
  const RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  late FocusNode nameFocus;
  late FocusNode lastNameFocus;
  late FocusNode ageFocus;
  late FocusNode addressFocus;
  late FocusNode phoneFocus;
  late FocusNode rutFocus;
  late FocusNode mailFocus;
  late FocusNode passwordFocus;
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController ageController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController rutController;
  late TextEditingController mailController;
  late TextEditingController passwordController;

  late var _items;
  int _selectedRelation = 0;
  //List<Categoria> _selectedAnimals2 = [];
  //List<Categoria> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  //List<Categoria> _selectedAnimals5 = [];
  //final _multiSelectKey = GlobalKey<FormFieldState>();

  List<Relation> relations = [
    Relation(id: 1, name: "Estudia"),
    Relation(id: 2, name: "Trabaja"),
    Relation(id: 3, name: "Vive")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    ageFocus = FocusNode();
    addressFocus = FocusNode();
    phoneFocus = FocusNode();
    rutFocus = FocusNode();
    mailFocus = FocusNode();
    passwordFocus = FocusNode();

    nameController = TextEditingController();
    lastNameController = TextEditingController();
    ageController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    rutController = TextEditingController();
    mailController = TextEditingController();
    passwordController = TextEditingController();

    _items = relations
        .map((relation) => MultiSelectItem<Relation>(relation, relation.name))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationRegistrated) {
          print("Fue un exito");
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Te has registrado con éxito!",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ).then((value) => Navigator.of(context).pop());
        } else if (state is AuthenticationError) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Ha habido un problema con tu registro.",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          );
          print("Paso algo");
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is AuthenticationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return Container(
            decoration: BoxDecoration(color: ColorPrimary.primaryColor),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Nombres",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: nameFocus,
                                textController: nameController,
                                label: "Nombres",
                                icons: const Icon(Icons.person,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Apellidos",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: lastNameFocus,
                                textController: lastNameController,
                                label: "Apellidos",
                                icons: const Icon(Icons.person,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Edad",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: ageFocus,
                                textController: ageController,
                                label: "Edad",
                                icons: const Icon(Icons.timelapse,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    "Relación con el barrio",
                                    style: appTextTheme.titleLarge!.copyWith(
                                        color: ColorPrimary.primaryColor),
                                  ),
                                ),
                                DropdownButtonFormField<Relation>(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  items: relations
                                      .map((e) => DropdownMenuItem<Relation>(
                                            child: Text(e.name),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) => setState(() {
                                    _selectedRelation = value!.id;
                                  }),
                                  value: null,
                                  hint: Text("Selecciona una alternativa"),
                                ),
                              ],
                            ),
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Dirección",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: addressFocus,
                                textController: addressController,
                                label: "Dirección",
                                icons: const Icon(Icons.map,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Teléfono",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: phoneFocus,
                                textController: phoneController,
                                label: "Teléfono",
                                icons: const Icon(Icons.phone,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Rut",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: rutFocus,
                                textController: rutController,
                                label: "Rut",
                                icons: const Icon(Icons.person,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Correo",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: mailFocus,
                                textController: mailController,
                                label: "Correo",
                                icons: const Icon(Icons.mail,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Contraseña",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              InputField(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                focusNode: passwordFocus,
                                textController: passwordController,
                                label: "Contraseña",
                                icons: const Icon(Icons.lock,
                                    color: ColorNeutral.neutralWhite),
                                isPassword: false,
                                backgroundColor: ColorPrimary.primaryColor,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(children: [
                                TextSpan(
                                  text:
                                      "Al hacer click en registrar usted está de acuerdo con nuestros ",
                                  style: labels.copyWith(color: Colors.black),
                                ),
                                TextSpan(
                                    text: "Términos y Condiciones de Uso",
                                    style: labels.copyWith(
                                        color: ColorPrimary.primaryColor,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print("Abrir terminos y condiciones");
                                        _launchUrl();
                                      }),
                              ]),
                            ),
                          ),
                          /* verticalSpace20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Categorías",
                                style: appTextTheme.titleLarge!
                                    .copyWith(color: ColorPrimary.primaryColor),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: MultiSelectDialogField(
                                items: _items,
                                title: Text("Categorias"),
                                selectedColor: ColorPrimary.primaryColor,
                                decoration: BoxDecoration(
                                  color: ColorPrimary.primaryColor,
                                  //borderRadius: BorderRadius.all(Radius.circular(40)),
                                  /* border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ), */
                                ),
                                buttonIcon: Icon(
                                  Icons.list,
                                  color: ColorNeutral.neutralWhite,
                                ),
                                buttonText: Text(
                                  "Selecciona Categorías",
                                  style: TextStyle(
                                    //color: Colors.blue[800],
                                    color: ColorNeutral.neutralWhite,
                                    fontSize: 16,
                                  ),
                                ),
                                onConfirm: (List<Relation> results) {
                                  _selectedCategories =
                                      results.map((e) => e.id).toList();
                                  //print(_selectedCategories);
                                },
                              ),
                            ),
                          ],
                        ), */
                          verticalSpace20,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BounceButton(
                              buttonSize: ButtonSize.medium,
                              type: ButtonType.primary,
                              label: "Registrarse",
                              onPressed: () async {
                                /* var form = RegistrationForm(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  categories: _selectedCategories,
                                  hours: costController.text,
                                  images: []);

                              
                  
                              CreatePublicationBloc a =
                                  BlocProvider.of<CreatePublicationBloc>(context); */

                                /* BlocProvider.of<CreatePublicationBloc>(context)
                                ..add(CreatePublication(form)); */

                                //print(ageController.text);

                                var registrationForm = RegistrationForm(
                                  password: passwordController.text,
                                  name: nameController.text,
                                  lastName: lastNameController.text,
                                  relation: _selectedRelation.toString(),
                                  /* age: (ageController.text == "")
                                      ? 0
                                      : int.parse(ageController.text), */
                                  age: ageController.text,
                                  address: addressController.text,
                                  phone: phoneController.text,
                                  rut: rutController.text,
                                  email: mailController.text,
                                );

                                print(registrationForm.toJson());

                                if (validator(registrationForm)) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomPopup(
                                      message: "Quieres registrarte?",
                                      buttonCancel: BounceButton(
                                        textColor: Colors.white,
                                        type: ButtonType.primary,
                                        buttonSize: ButtonSize.small,
                                        label: "SI",
                                        onPressed: () {
                                          print(registrationForm.age);
                                          print(
                                              registrationForm.age.runtimeType);
                                          BlocProvider.of<AuthenticationBloc>(
                                              context)
                                            ..add(Register(registrationForm));
                                          //a..add(CreatePublication(form));
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      buttonAccept: BounceButton(
                                        textColor: Colors.white,
                                        type: ButtonType.primary,
                                        buttonSize: ButtonSize.small,
                                        label: "NO",
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                  );
                                } else {
                                  print("FALTAN CAMPOS");
                                }

                                /* Navigator.of(context).pushNamed(
                              '/publications/create',
                            ); */
                              },
                              textColor: ColorNeutral.neutralWhite,
                              iconLeft: Icons.add_box,
                              backgroundColor: ColorPrimary.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
      },
    );
  }
}

bool validator(RegistrationForm registrationForm) {
  if (registrationForm.name != "" &&
      registrationForm.lastName != "" &&
      registrationForm.address != "" &&
      registrationForm.phone != "" &&
      registrationForm.rut != "" &&
      registrationForm.email != "" &&
      registrationForm.password != "" &&
      registrationForm.age != 0) {
    print("llego aca, estan todos");
    return true;
  } else {
    print("LLEGO AL ELSE, faltan campos");
    return false;
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(Uri.parse(
      "https://$baseUrl/BDT_Terminos_y_Condiciones-a078371d63.pdf"))) {
    throw 'Could not launch';
  }
}
