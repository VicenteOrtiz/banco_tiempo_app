import 'package:banco_tiempo_app/cross_features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:banco_tiempo_app/features/registration/domain/registration_form_entity.dart';
import 'package:banco_tiempo_app/features/settings/domain/edit_profile_entity.dart';
import 'package:banco_tiempo_app/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:banco_tiempo_app/secrets.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';
import '../../../profile/domain/profile_entity.dart';

class PersonalDataEditPage extends StatelessWidget {
  final Profile profile;
  const PersonalDataEditPage({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: Text("Editar Datos Personales"),
          centerTitle: true,
        ),
        body: PersonalDataEditBody(
          profile: profile,
        ));
  }
}

//TODO: missing upload images because API is unclear.

class PersonalDataEditBody extends StatefulWidget {
  final Profile profile;
  const PersonalDataEditBody({Key? key, required this.profile})
      : super(key: key);

  @override
  State<PersonalDataEditBody> createState() => _PersonalDataEditBodyState();
}

class _PersonalDataEditBodyState extends State<PersonalDataEditBody> {
  late FocusNode nameFocus;
  late FocusNode lastNameFocus;
  late FocusNode ageFocus;
  late FocusNode rutFocus;
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController lastNameController;
  late TextEditingController ageController;
  late TextEditingController rutController;

  late var _items;
  int _selectedRelation = 0;
  //List<Categoria> _selectedAnimals2 = [];
  //List<Categoria> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  //List<Categoria> _selectedAnimals5 = [];
  //final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameFocus = FocusNode();
    lastNameFocus = FocusNode();
    ageFocus = FocusNode();
    rutFocus = FocusNode();

    nameController = TextEditingController();
    nameController.text = widget.profile.name;
    lastNameController = TextEditingController();
    lastNameController.text = widget.profile.lastName;
    ageController = TextEditingController();
    rutController = TextEditingController();
    rutController.text = widget.profile.rut;
    dateController = TextEditingController();
    dateController.text = widget.profile.birthday;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is ProfileEdited) {
          print("Fue un exito");
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Has editado tu perfil con éxito!",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ).then((value) => Navigator.of(context).pop());
        } else if (state is SettingsError) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Ha habido un problema con la edición de tu perfil.",
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
        if (state is EditingLoading) {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.end,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Fecha de Nacimiento",
                                  style: appTextTheme.titleLarge!.copyWith(
                                      color: ColorPrimary.primaryColor),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  color: ColorPrimary.primaryColor,
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    controller:
                                        dateController, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.white,
                                        ), //icon of text field
                                        labelText:
                                            "Selecciona Fecha" //label text of field
                                        ),
                                    readOnly:
                                        true, // when true user cannot edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  1900), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          dateController.text =
                                              formattedDate; //set foratted date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BounceButton(
                              buttonSize: ButtonSize.medium,
                              type: ButtonType.primary,
                              label: "Editar",
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

                                var editProfileForm = EditProfileForm(
                                  name: nameController.text,
                                  lastName: lastNameController.text,
                                  fechaNacimiento: (dateController.text != "")
                                      ? DateTime.parse(dateController.text)
                                      : null,
                                  rut: rutController.text,
                                );

                                print(editProfileForm.toJson());

                                showDialog(
                                  context: context,
                                  builder: (context) => CustomPopup(
                                    message: "Quieres editar?",
                                    buttonCancel: BounceButton(
                                      textColor: Colors.white,
                                      type: ButtonType.primary,
                                      buttonSize: ButtonSize.small,
                                      label: "SI",
                                      onPressed: () {
                                        /* print(registrationForm.age);
                                          print(
                                              registrationForm.age.runtimeType);
                                          BlocProvider.of<AuthenticationBloc>(
                                              context)
                                            ..add(Register(registrationForm));
                                          //a..add(CreatePublication(form));
                                          Navigator.of(context).pop(); */
                                        BlocProvider.of<SettingsBloc>(context)
                                          ..add(EditProfile(editProfileForm));
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
