import 'package:banco_tiempo_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/bloc/messages_bloc.dart';
import 'package:banco_tiempo_app/features/messages_poc/presentation/widgets/pending_messages_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../my_services/infraestructure/models/pending_services_dto.dart';

class PendingMessagesList extends StatelessWidget {
  final List<RequestedServiceDto> services;
  final Widget? header;
  final Widget? footer;
  final bool confirmed;

  const PendingMessagesList({
    required this.services,
    required this.confirmed,
    this.footer,
    this.header,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildBody(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (header != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: header,
          ),
          const Divider(height: 1, thickness: 1),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildFooter() {
    if (footer != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(height: 1, thickness: 1),
          footer!,
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildBody() =>
      services.isNotEmpty ? _buildTransactionList() : _buildNoTransaction();

  Widget _buildTransactionList() => Column(
        children: [
          ...services
              .map(
                (s) => Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        print("HIZO CLICK EN EL SERVICIO");
                        BlocProvider.of<MessagesBloc>(context)
                          ..add(GetMessages(serviceId: s.id));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/message',
                          (Route<dynamic> route) => route is Dashboard,
                        );
                        /* Navigator.of(context)
                            .pushNamed('/message')
                            .then((value) {
                          print("HOLA");

                          /* BlocProvider.of<MessagesBloc>(context)
                            ..add(GetPendingMessages()); */
                          /* context.read<MessagesBloc>()
                            ..add(GetPendingMessages()); */
                        }); */
                        /* if (confirmed) {
                          Navigator.of(context)
                              .pushNamed('/my-services/requested-details',
                                  arguments: s)
                              .then((value) {
                            print("VOLVIO");
                            BlocProvider.of<MyServicesBloc>(context)
                              ..add(GetMyServices());
                          });
                        } else {
                          Navigator.of(context)
                              .pushNamed('/my-services/details', arguments: s)
                              .then((value) {
                            print("VOLVIO");
                            BlocProvider.of<MyServicesBloc>(context)
                              ..add(GetMyServices());
                          });
                        } */
                      },
                      child: PendingMessagesListItem(
                        requestedService: s,
                      ),
                    );
                  },
                ),
              )
              .toList()
        ],
      );

  Widget _buildNoTransaction() => Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            "No hay servicios",
          ),
        ),
      );
}
