import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card(int opt) {
      List<String> titles = [
        "Mi Perfil",
        "Nuevo Invitado",
        "Abrir Portón",
        "Reclamo",
        "Avisos Comunidad",
        "Varios Edificio"
      ];
      List<IconData> icons = [
        Icons.person_search_rounded,
        Icons.person_add,
        Icons.car_rental,
        Icons.warning,
        Icons.info,
        Icons.location_city
      ];
      return InkWell(
        onTap: () {
          print("click");
          if (opt == 3) {
            print("opt3");
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
              Icon(icons[opt], size: 70, color: Theme.of(context).primaryColor),
              Text(titles[opt])
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 10, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          "Bastian Vera",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100),
                        )
                      ],
                    ),
                    //Icon(Icons.person)
                    CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/images/basti.jpg"),
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              //SizedBox(height: 200,),

              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [card(0), card(1)],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [card(2), card(3)],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [card(4), card(5)],
                      ),
                    ])),
              )
            ],
          ),
        ),
        endDrawer: Drawer(),
        /* bottomNavigationBar: bottomAppBar(context),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
              },
          tooltip: 'Increment',
          child: Icon(Icons.home , color: Colors.white),
          elevation: 2.0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, */
      ),
    );
  }
}
