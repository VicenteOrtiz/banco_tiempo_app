import '../infraestructure/models/pending_services_dto.dart';

class MyServices {
  List<RequestedServiceDto> porConfirmar;
  List<RequestedServiceDto> solicitado;

  MyServices({required this.porConfirmar, required this.solicitado});
}
