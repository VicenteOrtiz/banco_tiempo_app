import 'package:banco_tiempo_app/app/presentation/app_theme.dart';
import 'package:banco_tiempo_app/app/presentation/shared_widgets/custom_input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //color: ColorPrimary.primaryColor,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  ColorGradient.leftColor,
                  ColorGradient.rightColor,
                ]),
          ),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorGradient.leftColor,
                          ColorGradient.rightColor,
                        ]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_banco.png',
                        width: 150,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    color: ColorNeutral.neutralWhite,
                  ),
                  width: double.infinity,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      verticalSpace16,
                      Text(
                        "Ingresar al Banco del Tiempo",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      verticalSpace16,
                      Divider(),
                      verticalSpace16,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Correo o Teléfono",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 300,
                            //height: 20,
                            //color: Colors.grey,
                            child: TextFormField(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contraseña",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 300,
                            //height: 20,
                            //color: Colors.grey,
                            child: TextFormField(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 147, 48, 106)),
                          onPressed: () {},
                          child: Text("ENTRAR"),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Olvidé mi contraseña"),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
