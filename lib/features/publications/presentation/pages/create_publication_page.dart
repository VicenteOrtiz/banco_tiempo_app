import 'package:banco_tiempo_app/cross_features/category/domain/category_entity.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import '../../create/bloc/create_publication_bloc.dart';
import '../../create/entity/create_publication_form_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';

class CreatePublicationPage extends StatelessWidget {
  final List<Categoria> categories;
  const CreatePublicationPage({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Nueva Publicación"),
      ),
      body: BlocProvider(
        create: (context) => CreatePublicationBloc(),
        child: CreatePublicationBody(
          categories: categories,
        ),
      ),
    );
  }
}

//TODO: missing upload images because API is unclear.

class CreatePublicationBody extends StatefulWidget {
  final List<Categoria> categories;
  const CreatePublicationBody({Key? key, required this.categories})
      : super(key: key);

  @override
  State<CreatePublicationBody> createState() => _CreatePublicationBodyState();
}

class _CreatePublicationBodyState extends State<CreatePublicationBody> {
  late FocusNode titleFocus;
  late FocusNode descriptionFocus;
  late FocusNode costFocus;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController costController;

  late var _items;
  List<String> _selectedCategories = [];
  List<Categoria> _selectedAnimals2 = [];
  List<Categoria> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Categoria> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleFocus = FocusNode();
    descriptionFocus = FocusNode();
    costFocus = FocusNode();

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    costController = TextEditingController();

    _items = widget.categories
        .map((categoria) =>
            MultiSelectItem<Categoria>(categoria, categoria.nombre))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePublicationBloc, CreatePublicationState>(
      listener: (context, state) {
        if (state is CreatePublicationSuccesfull) {
          print("Fue un exito");
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Tu publicación ha sido creada con éxito!",
              buttonAccept: BounceButton(
                textColor: Colors.white,
                type: ButtonType.primary,
                buttonSize: ButtonSize.small,
                label: "Entendido",
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ).then((value) => Navigator.of(context).pop());
        } else if (state is CreatePublicationError) {
          showDialog(
            context: context,
            builder: (context) => CustomPopup(
              message: "Ha habido un problema creando tu publicación",
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
                  child: Column(
                    children: [
                      verticalSpace32,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Titulo",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          InputField(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            focusNode: titleFocus,
                            textController: titleController,
                            label: "Titulo",
                            icons: const Icon(Icons.person,
                                color: ColorNeutral.neutralWhite),
                            isPassword: false,
                            backgroundColor: ColorPrimary.primaryColor,
                          ),
                        ],
                      ),
                      verticalSpace32,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Descripción",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          InputField(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            focusNode: descriptionFocus,
                            textController: descriptionController,
                            label: "Descripcion",
                            icons: const Icon(Icons.person,
                                color: ColorNeutral.neutralWhite),
                            isPassword: false,
                            backgroundColor: ColorPrimary.primaryColor,
                          ),
                        ],
                      ),
                      verticalSpace32,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Costo",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          InputField(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            focusNode: costFocus,
                            textController: costController,
                            label: "Costo",
                            icons: const Icon(Icons.timelapse,
                                color: ColorNeutral.neutralWhite),
                            isPassword: false,
                            backgroundColor: ColorPrimary.primaryColor,
                          ),
                        ],
                      ),
                      verticalSpace32,
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
                              onConfirm: (List<Categoria> results) {
                                _selectedCategories =
                                    results.map((e) => e.id).toList();
                                //print(_selectedCategories);
                              },
                            ),
                          ),
                          /* InputField(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            focusNode: costFocus,
                            textController: costController,
                            label: "Costo",
                            icons: const Icon(Icons.timelapse,
                                color: ColorNeutral.neutralWhite),
                            isPassword: false,
                            backgroundColor: ColorPrimary.primaryColor,
                          ), */
                        ],
                      ),
                      verticalSpace32,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "PUBLICAR",
                          onPressed: () async {
                            var form = CreatePublicationFormEntity(
                                title: titleController.text,
                                description: descriptionController.text,
                                categories: _selectedCategories,
                                hours: costController.text,
                                images: []);

                            CreatePublicationBloc a =
                                BlocProvider.of<CreatePublicationBloc>(context);

                            /* BlocProvider.of<CreatePublicationBloc>(context)
                              ..add(CreatePublication(form)); */

                            showDialog(
                              context: context,
                              builder: (context) => CustomPopup(
                                message: "Quieres crear el servicio?",
                                buttonCancel: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "SI",
                                  onPressed: () {
                                    a..add(CreatePublication(form));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                buttonAccept: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "NO",
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            );

                            print("NUEVA PUBLICACIÓN");
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
              )
            ],
          ),
        );
      },
    );
  }
}
