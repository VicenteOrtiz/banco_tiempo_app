import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../app/presentation/shared_widgets/custom_popup.dart';
import '../../../../cross_features/authentication/presentation/widgets/input_field.dart';
import '../../../../cross_features/badges/domain/badges_entity.dart';
import '../../infraestructure/payload/confirm_service_payload.dart';
import '../bloc/my_services_bloc.dart';

class ServiceReviewPage extends StatelessWidget {
  final List<Badge> badges;
  final String serviceId;
  final Bloc bloc;
  const ServiceReviewPage(
      {Key? key,
      required this.badges,
      required this.serviceId,
      required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Evalua el Servicio"),
        centerTitle: true,
      ),
      body: ServiceReviewPageBody(
        badges: badges,
        bloc: bloc,
        serviceId: serviceId,
      ),
    );
  }
}

class ServiceReviewPageBody extends StatefulWidget {
  final List<Badge> badges;
  final String serviceId;
  final Bloc bloc;
  const ServiceReviewPageBody(
      {Key? key,
      required this.badges,
      required this.serviceId,
      required this.bloc});

  @override
  State<ServiceReviewPageBody> createState() => _ServiceReviewPageState();
}

class _ServiceReviewPageState extends State<ServiceReviewPageBody> {
  late FocusNode commentFocus;
  late TextEditingController commentController;
  late var _items;
  List<String> _selectedBadges = [];
  int ratingPL = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentFocus = FocusNode();
    commentController = TextEditingController();
    _items = widget.badges
        .map((badges) => MultiSelectItem<Badge>(badges, badges.nombre))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyServicesBloc, MyServicesState>(
      listener: (context, state) {
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Como calificaría este servicio?",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: RatingBar.builder(
                              initialRating: ratingPL.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                ratingPL = rating.toInt();
                                print(rating);
                              },
                            ),
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
                              "Seleccione las cualidades destacables",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: MultiSelectDialogField(
                              items: _items,
                              title: Text("Cualidades Destacables"),
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
                                "Selecciona cualidades",
                                style: TextStyle(
                                  //color: Colors.blue[800],
                                  color: ColorNeutral.neutralWhite,
                                  fontSize: 16,
                                ),
                              ),
                              onConfirm: (List<Badge> results) {
                                _selectedBadges =
                                    results.map((e) => e.id).toList();
                                //print(_selectedCategories);
                              },
                            ),
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
                              "Comentarios",
                              style: appTextTheme.titleLarge!
                                  .copyWith(color: ColorPrimary.primaryColor),
                            ),
                          ),
                          InputField(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            focusNode: commentFocus,
                            textController: commentController,
                            label: "Deje algún comentario",
                            icons: const Icon(Icons.person,
                                color: ColorNeutral.neutralWhite),
                            isPassword: false,
                            backgroundColor: ColorPrimary.primaryColor,
                          ),
                        ],
                      ),
                      verticalSpace32,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BounceButton(
                          buttonSize: ButtonSize.medium,
                          type: ButtonType.primary,
                          label: "Finalizar Servicio",
                          onPressed: () async {
                            var payload = ConfirmServicePayload(
                                puntaje: 4,
                                comentario: commentController.text,
                                cualidades: _selectedBadges,
                                transaccionId: widget.serviceId);
                            showDialog(
                              context: context,
                              builder: (context) => CustomPopup(
                                //title: "HOLA",
                                message: "Quieres finalizar el servicio?",
                                buttonCancel: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "SI",
                                  onPressed: () {
                                    widget.bloc
                                      ..add(FinishService(
                                          confirmServicePayload: payload));
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

                            /* var form = CreatePublicationFormEntity(
                                title: titleController.text,
                                description: descriptionController.text,
                                categories: _selectedCategories,
                                hours: costController.text,
                                images: []); */

                            /* CreatePublicationBloc a =
                                BlocProvider.of<CreatePublicationBloc>(context); */

                            /* BlocProvider.of<CreatePublicationBloc>(context)
                              ..add(CreatePublication(form)); */

                            /* showDialog(
                              context: context,
                              builder: (context) => CustomPopup(
                                message: "Quieres finalizar el servicio?",
                                buttonCancel: BounceButton(
                                  textColor: Colors.white,
                                  type: ButtonType.primary,
                                  buttonSize: ButtonSize.small,
                                  label: "SI",
                                  onPressed: () {
                                    //a..add(CreatePublication(form));
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
                            ); */

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
