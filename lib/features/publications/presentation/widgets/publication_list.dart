import '../../domain/publication_entity.dart';
import '../bloc/publication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'publication_list_item.dart';

class MyPublicationsList extends StatelessWidget {
  final List<Publication> publications;
  final Widget? header;
  final Widget? footer;

  const MyPublicationsList({
    required this.publications,
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
      publications.isNotEmpty ? _buildTransactionList() : _buildNoTransaction();

  Widget _buildTransactionList() => Column(
        children: [
          ...publications
              .map(
                (s) => Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        print("HIZO CLICK EN EL SERVICIO");
                        /* AutoRouter.of(context).push(
                          TransactionDetailsView(
                            transaction: t,
                          ),
                        ); */
                        Navigator.of(context)
                            .pushNamed('/publications/details', arguments: s)
                            .then((value) {
                          print("VOLVIO");
                          BlocProvider.of<PublicationBloc>(context)
                            ..add(GetPublications());
                        });
                      },
                      child: PublicationListItem(
                        publication: s,
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
