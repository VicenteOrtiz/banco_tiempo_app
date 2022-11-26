import 'package:banco_tiempo_app/cross_features/validators/is_me_validator.dart';
import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/bloc/messages_bloc.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/widgets/pending_messages_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/app_theme.dart';
import '../../../../app/presentation/shared_widgets/custom_label.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class PendingMessagesPage extends StatelessWidget {
  const PendingMessagesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPrimary.primaryColor,
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: Text("Mensajes"),
        centerTitle: true,
      ),
      /* body: BlocProvider(
        create: (context) => MessagesBloc()
          ..add(
            GetPendingMessages(),
          ),
        child: PendingMessagesBody(),
      ), */
      body: PendingMessagesBody(),
    );
  }
}

class PendingMessagesBody extends StatelessWidget {
  const PendingMessagesBody({Key? key});

  @override
  Widget build(BuildContext context) {
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
                    /* verticalSpace12,
                    _buildTransactionSection("Servicios que solicité", false), */
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTransactionSection(
  String title,
  //PageRouteInfo viewAllPage,
  bool confirmed,
) {
  return Column(
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
            BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is PendingMessagesLoaded) {
                  var pendingMessages = state.pendingMessages.servicios;
                  if (pendingMessages.isNotEmpty) {
                    return PendingMessagesList(
                        confirmed: confirmed,
                        services: pendingMessages.length > 5
                            ? pendingMessages.sublist(0, 5)
                            : pendingMessages,
                        footer: null);
                  } else {
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text("No se encontraron Servicios en Curso"),
                        ),
                      )
                    ]);
                  }
                } else if (state is PendingMessagesError) {
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
