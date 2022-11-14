import '../../../../app/presentation/app_theme.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import '../../create/bloc/create_publication_bloc.dart';
import '../../create/entity/create_publication_form_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';

class CreatePublicationPage extends StatelessWidget {
  const CreatePublicationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Nueva Publicación"),
      ),
      body: BlocProvider(
        create: (context) => CreatePublicationBloc(),
        child: CreatePublicationBody(),
      ),
    );
  }
}

class CreatePublicationBody extends StatefulWidget {
  const CreatePublicationBody({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
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
                  verticalSpace40,
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
                  verticalSpace40,
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
                  verticalSpace40,
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
                  verticalSpace40,
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
                            categories: [],
                            hours: costController.text,
                            images: []);

                        BlocProvider.of<CreatePublicationBloc>(context)
                            .add(CreatePublication(form));

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
  }
}
