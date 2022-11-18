import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/my_services/infraestructure/models/historic_transactions_dto.dart';
import 'package:banco_tiempo_app/features/my_services/presentation/bloc/my_services_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/presentation/app_theme.dart';

class HistoricTransactionsPage extends StatelessWidget {
  const HistoricTransactionsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Historial de Transacciones"),
        centerTitle: true,
      ),
      body: BlocConsumer<MyServicesBloc, MyServicesState>(
        listener: (context, state) {
          if (state is MyServicesError) {
            print("PAGO ALGO CON LAS TRANSACCIONES");
          }
        },
        builder: (context, state) {
          if (state is HistoricTransactionsLoaded) {
            return dataTableLayout(
                context, state.historicTransactionsDto.reversed.toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget dataTableLayout(
    BuildContext context, List<HistoricTransactionsDto> transactions) {
  List<DataColumn> _createColumns = [
    DataColumn(
      label: Text("Titulo"),
    ),
    DataColumn(
      label: Text("Ofrece"),
    ),
    DataColumn(
      label: Text("Solicita"),
    ),
    DataColumn(
      label: Text("Bonos"),
    ),
    DataColumn(
      label: Text("Solicitado"),
    ),
    DataColumn(
      label: Text("Ejecutado"),
    ),
    DataColumn(
      label: Text("Estado"),
    )
  ];

  Widget _status(HistoricTransactionsDto transaction) {
    if (transaction.aceptado && transaction.finalizado != "") {
      return Text("Finalizado");
    } else if (transaction.cancelado) {
      return Text(
        "Cancelado",
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Text("En Progreso");
    }
  }

  List<DataRow> _createRows = transactions
      .map((transaction) => DataRow(cells: [
            DataCell(Text(transaction.servicio.titulo)),
            DataCell(Text(
                transaction.ofrece.name + " " + transaction.ofrece.lastName)),
            DataCell(Text(transaction.solicita.name +
                " " +
                transaction.solicita.lastName)),
            DataCell(Text(transaction.horas.toString())),
            DataCell(Text(DateFormat('dd/MM/yyyy').format(transaction.creado))),
            DataCell(
                Text(DateFormat('dd/MM/yyyy').format(transaction.finalizado))),
            DataCell(_status(transaction)),
          ]))
      .toList();

  return Container(
    //width: double.infinity,
    decoration: BoxDecoration(color: ColorPrimary.primaryColor),
    child: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 8.0, left: 8.0, top: 0, bottom: 20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Icon(Icons.person)
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
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                //padding: EdgeInsets.all(1),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: _createColumns,
                        rows: _createRows,
                      ),
                    )
                  ],
                ),
              )),
        )
      ],
    ),
  );
}
