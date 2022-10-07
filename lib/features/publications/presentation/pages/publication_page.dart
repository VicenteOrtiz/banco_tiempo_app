import 'package:banco_tiempo_app/cross_features/widgets/appbar_widget.dart';
import 'package:banco_tiempo_app/features/publications/presentation/bloc/publication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/publication_entity.dart';

class PublicationPage extends StatelessWidget {
  const PublicationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Mis Publicaciones"),
        centerTitle: true,
      ),
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
    return Container();
  }
}
