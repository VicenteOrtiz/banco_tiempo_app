import 'package:banco_tiempo_app/cross_features/category/infraestructure/category_repository.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../cross_features/widgets/appbar_widget.dart';
import '../../../../cross_features/widgets/drawer_widget.dart';
import '../bloc/publication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/shared_widgets/bounce_button.dart';
import '../../../../app/presentation/shared_widgets/custom_label.dart';
import '../../domain/publication_entity.dart';
import '../widgets/publication_list.dart';

class PublicationPage extends StatelessWidget {
  const PublicationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Mis Publicaciones"),
        centerTitle: true,
      ),
      drawer: DrawerWidget(context),
      body: BlocProvider<PublicationBloc>(
        create: (context) => PublicationBloc()..add(GetPublications()),
        child: BlocBuilder<PublicationBloc, PublicationState>(
          builder: (context, state) {
            if (state is PublicationLoaded) {
              print(state.publications);
              return publicationLayout(context, state.publications);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget publicationLayout(
      BuildContext context, List<Publication> publications) {
    CategoryRepository _categoryRepository = CategoryRepository();
    return Container(
      color: ColorPrimary.primaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 0, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BounceButton(
                    buttonSize: ButtonSize.medium,
                    type: ButtonType.primary,
                    label: "Nueva Publicación",
                    onPressed: () async {
                      print("NUEVA PUBLICACIÓN");
                      var categorias =
                          await _categoryRepository.getCategories();
                      Navigator.of(context).pushNamed('/publications/create',
                          arguments: categorias);
                    },
                    textColor: ColorPrimary.primaryColor,
                    iconLeft: Icons.add_box,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            _buildPublicationsSection("Publicadas", false),
                            verticalSpace12,
                            _buildPublicationsSection("Ocultas", true),
                            //_buildTransactionSection("Servicios por Confirmar", false),
                          ],
                        ),
                      ),
                    ),
                    //_buildPublicationsSection("Publicadas", true),
                  ],
                ),
              ),
              //width: double.infinity,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPublicationsSection(
    String title,
    //PageRouteInfo viewAllPage,
    bool hidden,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorPrimary.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: appTextTheme.bodyText1,
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: ColorPrimary.primaryColor,
                ),
                BlocBuilder<PublicationBloc, PublicationState>(
                  builder: (context, state) {
                    if (state is PublicationLoaded) {
                      var publications = hidden
                          ? state.hiddenPublications
                          : state.publications;
                      if (publications.isNotEmpty) {
                        return MyPublicationsList(
                          /* publications: publications.length > 5
                              ? publications.sublist(0, 5)
                              : publications, */

                          publications: publications,

                          /* footer: publications.length > 1
                              ? CustomLabel(
                                  labelText: 'Ver todos los Servicios',
                                  //nextPage: viewAllPage,
                                )
                              : null, */
                        );
                      } else {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: hidden
                                  ? Text(
                                      "No se encontraron Servicios Confirmados")
                                  : Text(
                                      "No se encontraron Servicios por Confirmar"),
                            ),
                          )
                        ]);
                      }
                    } else if (state is PublicationError) {
                      return Text("HUBO UN ERROR");
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    /* return state.maybeWhen(
                      loaded: (transactions) => TransactionList(
                        transactions: transactions.length > 5
                            ? transactions.sublist(0, 5)
                            : transactions,
                        footer: transactions.length > 1
                            ? CustomLabel(
                                labelText:
                                    '${_transactionTranslation}view_all'.tr(),
                                nextPage: viewAllPage,
                              )
                            : null,
                      ),
                      error: Text.new,
                      notFound: () => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: isProcessed
                                  ? Text(
                                      '''${_transactionTranslation}no_processed_transactions'''
                                          .tr(),
                                    )
                                  : Text(
                                      '''${_transactionTranslation}no_transactions'''
                                          .tr(),
                                    ),
                            ),
                          ),
                          if (isProcessed)
                            const Divider(height: 1, thickness: 1),
                          if (isProcessed)
                            CustomLabel(
                              labelText:
                                  '${_transactionTranslation}view_all'.tr(),
                              nextPage: viewAllPage,
                            )
                        ],
                      ),
                      orElse: _loading,
                    ); */
                  },
                ),
              ],
            ),
          ),
        ],
      );
}
