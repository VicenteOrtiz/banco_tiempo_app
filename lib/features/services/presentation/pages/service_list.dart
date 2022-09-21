import 'package:banco_tiempo_app/features/poc/presentation/bloc/poc_bloc.dart';
import 'package:banco_tiempo_app/features/poc/presentation/pages/post_detail.dart';
import 'package:banco_tiempo_app/features/services/presentation/bloc/service_bloc.dart';
import 'package:flutter/material.dart';

import '../../../poc/presentation/widgets/bottom_loader.dart';
import '../widgets/service_box.dart';

class ServiceList extends StatelessWidget {
  const ServiceList({
    Key? key,
    required this.scrollController,
    required this.state,
  }) : super(key: key);

  final ScrollController scrollController;
  final ServiceLoaded state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4,
        crossAxisCount: 2,
      ),
      itemCount: state.hasReachedMax
          ? state.services.length
          : state.services.length + 1,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index >= state.services.length) return BottomLoader();

        //return Text(state.services[index].titulo);

        return serviceBox(state.services[index]);
        /* return ListTile(
          leading: Text(state.services[index].id.toString()),
          title: Text(
            state.services[index].titulo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            state.services[index].descripcion,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
          onTap: () {
            print("HOLA");
            /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetail(post: state.posts[index]),
              ),
            ); */
          },
        ); */
      },
      /* separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 1,
      ), */
    );
  }
}
