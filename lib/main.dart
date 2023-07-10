import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plenumapp/page/Second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          LoginPage(), // Usamos un nuevo widget LoginPage para realizar la navegación
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sistema de Células Plenum Móvil"), backgroundColor: Colors.black),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          width: 350,
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Image.asset(
                      'assets/CelulasPlenum_Negro.png',
                      width: 200, // Ancho de la imagen
                      height: 200,
                    ),
                    TextField(
                      controller: userController,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person_2_sharp),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)
                        ),
                        
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: Icon(Icons.password_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Llamamos al método _login para realizar la navegación
                        login(context);
                      },
                      label: Text(
                        "Iniciar Sesión",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.login_outlined),
                    ),
                    const SizedBox(height: 10.0),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    final url = Uri.parse('https://localhost:5001/api/Usuario/login');

    final body = json.encode({
      'correoElectronico': userController.text,
      'password': passwordController.text,
    });

    final headers = {
      'Content-Type':
          'application/json', // Establece el tipo de contenido como JSON
      'Authorization':
          'Bearer your_token_here', // Agrega tu encabezado de autorización
    };

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
       
      final token = json.decode(response.body)['data']['token'];
      
      
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'api_token', value: token);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Second()));
    } else {
      // La solicitud falló
       
    }
  }
}
