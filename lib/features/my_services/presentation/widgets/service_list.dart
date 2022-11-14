import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infraestructure/models/pending_services_dto.dart';
import '../bloc/my_services_bloc.dart';
import 'service_list_item.dart';

class MyServiceList extends StatelessWidget {
  final List<RequestedServiceDto> services;
  final Widget? header;
  final Widget? footer;
  final bool confirmed;

  const MyServiceList({
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
                        if (confirmed) {
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
                        }
                      },
                      child: ServiceListItem(
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
