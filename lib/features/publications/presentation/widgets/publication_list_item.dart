import 'package:banco_tiempo_app/features/publications/domain/publication_entity.dart';
import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';

class PublicationListItem extends StatelessWidget {
  final Publication publication;
  const PublicationListItem({
    required this.publication,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 24,
        child: Icon(
          Icons.handshake,
          color: ColorPrimary.primaryColor,
        ),
      ),
      title: Text(
        publication.titulo,
        style: appTextTheme.bodyText2,
      ),
      subtitle: Text(
        publication.publicado.toString(),
        style: labels,
      ),
      trailing: Text(
        'Ver más',
        style:
            appTextTheme.subtitle1?.copyWith(color: ColorPrimary.primaryColor),
      ),
    );
  }
}
