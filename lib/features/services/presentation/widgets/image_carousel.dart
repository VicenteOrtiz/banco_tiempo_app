import 'package:flutter/material.dart';

import '../../../../secrets.dart';
import '../../domain/service_entity.dart';

class ImageCarousel extends StatefulWidget {
  final Service service;
  const ImageCarousel({Key? key, required this.service}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PageView.builder(
          itemCount: widget.service.imagenes.length,
          pageSnapping: true,
          itemBuilder: (context, pagePosition) {
            return Container(
                margin: EdgeInsets.all(10),
                child: Image.network(
                    "https://$baseUrl${widget.service.imagenes[pagePosition]}"));
          }),
    );
  }
}
