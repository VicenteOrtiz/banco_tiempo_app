import 'package:flutter/material.dart';

import '../../../../app/presentation/app_theme.dart';

Widget CardWidget(int opt, BuildContext context) {
  List<String> titles = [
    "Buscar Servicio",
    "Mis Servicios",
    "Mis Reservas",
    "Mensajes",
    "Ayuda",
    "Mi Cuenta"
  ];
  List<IconData> icons = [
    Icons.search,
    Icons.person_add,
    Icons.car_rental,
    Icons.mail,
    Icons.info,
    Icons.location_city
  ];
  return InkWell(
    onTap: () {
      print("clicksss");
      if (opt == 3) {
        print("opt33");
        /* Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ClaimMenuPage())); */
      } else if (opt == 1) {
        print("opt1");
        /* Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NewGuestPage())); */
      } else if (opt == 4) {
        /* Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CommunityMessagesPage())); */
        print("opt4");
      }
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icons[opt], size: 70, color: ColorPrimary.primaryColor),
          Text(titles[opt])
        ],
      ),
    ),
  );
}
