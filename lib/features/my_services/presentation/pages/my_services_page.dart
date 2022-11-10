import '../../../../cross_features/widgets/appbar_widget.dart';
import '../bloc/my_services_bloc.dart';
import '../widgets/service_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_label.dart';

class MyServicesPage extends StatelessWidget {
  const MyServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Mis Servicios"),
      ),
      body: BlocProvider(
        create: (context) => MyServicesBloc()
          ..add(
            GetMyServices(),
          ),
        child: MyServicesBody(),
      ),
    );
  }
}

class MyServicesBody extends StatelessWidget {
  const MyServicesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTextTheme;
    return Container(
      decoration: BoxDecoration(color: ColorPrimary.primaryColor),
      child: Column(
        children: [
          Expanded(
            child: Container(
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
                    _buildTransactionSection("Servicios en Curso", true),
                    verticalSpace12,
                    _buildTransactionSection("Servicios que solicité", false),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionSection(
    String title,
    //PageRouteInfo viewAllPage,
    bool confirmed,
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
                BlocBuilder<MyServicesBloc, MyServicesState>(
                  builder: (context, state) {
                    if (state is MyServicesLoaded) {
                      var servicesList = confirmed
                          ? state.myServices.solicitado
                          : state.myServices.porConfirmar;
                      if (servicesList.isNotEmpty) {
                        return MyServiceList(
                          confirmed: confirmed,
                          services: servicesList.length > 5
                              ? servicesList.sublist(0, 5)
                              : servicesList,
                          footer: servicesList.length > 1
                              ? CustomLabel(
                                  labelText: 'Ver todos los Servicios',
                                  //nextPage: viewAllPage,
                                )
                              : null,
                        );
                      } else {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: confirmed
                                  ? Text("No se encontraron Servicios en Curso")
                                  : Text(
                                      "No se encontraron Servicios que solicité"),
                            ),
                          )
                        ]);
                      }
                    } else if (state is MyServicesError) {
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
