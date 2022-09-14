import 'package:banco_tiempo_app/features/login/login_page.dart';
import 'package:banco_tiempo_app/features/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 145, 30, 91),
                  Color.fromARGB(255, 25, 24, 96)
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_banco.png'),
              const SizedBox(height: 20),
              Text(
                "BANCO DE TIEMPO",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => LoginPage()),
                      ),
                    );
                  },
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(color: Color.fromARGB(255, 145, 30, 91)),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => RegisterPage()),
                      ),
                    );
                  },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(color: Color.fromARGB(255, 145, 30, 91)),
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
