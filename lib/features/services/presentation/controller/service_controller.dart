import 'package:flutter/material.dart';

import '../../domain/service_entity.dart';

class ServiceController {
  final int pages;
  final int actualPage;
  final List<Service> services;

  const ServiceController(
    this.pages,
    this.actualPage,
    this.services,
  );

  /* static ServiceController get initial {
    return const ServiceController(0, 0, []);
  } */

  /* ServiceController copyWith(
      {List<Service> services, int actualPage, int pages}) {
    return ServiceController(
      pages: pages ?? this.pages,
      actualPage: actualPage ?? this.actualPage,
      services: services ?? this.services,
    );
  } */
}
