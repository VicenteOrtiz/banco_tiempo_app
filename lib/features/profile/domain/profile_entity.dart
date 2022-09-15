class Profile {
  const Profile({
    required this.id,
    required this.address,
    required this.rut,
    required this.userType,
    required this.age,
    required this.phone,
    required this.relation,
    required this.lastName,
    required this.email,
    required this.name,
    required this.v,
    required this.logros,
    required this.notificacionesLeidas,
    required this.notificaciones,
    required this.categorias,
    required this.historialTransacciones,
    required this.transaccionesPendientes,
    required this.imagenUrl,
    required this.activo,
    required this.admin,
    required this.mensajesAyuda,
  });

  final String id;
  final String address;
  final String rut;
  final String userType;
  final int age;
  final String phone;
  final int relation;
  final String lastName;
  final String email;
  final String name;
  final int v;
  final List<dynamic> logros;
  final List<String> notificacionesLeidas;
  final List<String> notificaciones;
  final List<String> categorias;
  final List<String> historialTransacciones;
  final List<String> transaccionesPendientes;
  final String imagenUrl;
  final bool activo;
  final bool admin;
  final List<String> mensajesAyuda;
}
