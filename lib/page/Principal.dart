import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plenumapp/model/Alumno.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:plenumapp/page/Second.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  String _apiToken = '';

  @override
  void initState() {
    super.initState();
    _getApiToken();
  }

  void _getApiToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'api_token');
    setState(() {
      _apiToken = token ?? '';
    });
  }

  void _getCumpleaniosAnterior() async {
    final url = Uri.parse(
        'https://localhost:5001/api/V1/Notificaciones/CumpleañosAnterior');

    final headers = {
      'Authorization': 'Bearer $_apiToken',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
      
      _parseData(response.body);
      // Procesar la respuesta de la solicitud GET aquí
    } else {
      // La solicitud falló
       
    }
  }

  void _getCumpleaniosHoy() async {
    final url =
        Uri.parse('https://localhost:5001/api/V1/Notificaciones/CumplañosHoy');

    final headers = {
      'Authorization': 'Bearer $_apiToken',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
       
      _parseData(response.body);
      // Procesar la respuesta de la solicitud GET aquí
    } else {
      // La solicitud falló
      
    }
  }

  void _getCumpleaniosProximo() async {
    final url = Uri.parse(
        'https://localhost:5001/api/V1/Notificaciones/ProximoCumpleaños');

    final headers = {
      'Authorization': 'Bearer $_apiToken',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // La solicitud se realizó con éxito
     
      _parseData(response.body);
      // Procesar la respuesta de la solicitud GET aquí
    } else {
      // La solicitud fal
    }
  }

  List<Alumno> _alumnos = [];

  void _parseData(String responseBody) {
    final parsed = json.decode(responseBody);
    final alumnos = parsed['data'] as List<dynamic>;
    _alumnos = alumnos.map((alumno) => Alumno.fromJson(alumno)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sistema de Células Plenum Móvil'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Second()));
                  },
                  label: const Text("Ver Expedientes de Alumnos"),
                  icon: const Icon(Icons.archive_rounded),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  )),
              Image.asset(
                'assets/CelulasPlenum_Negro.png',
                width: 200,
                height: 200,
              ),
              Text(
                "Bienvenido al Sistema de Células Plenum Móvil",
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_month),
                          label: const Text("Cumpleaños Anterior"),
                          onPressed: _getCumpleaniosAnterior,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          )),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_month),
                          label: const Text("Cumpleaños de Hoy"),
                          onPressed: _getCumpleaniosHoy,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          )),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_month),
                          label: const Text("Cumpleaños Proximo"),
                          onPressed: _getCumpleaniosProximo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _alumnos.isEmpty
                    ? const Center(
                        child: Text(
                          'Sin Eventos',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _alumnos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final alumno = _alumnos[index];
                          return ListTile(
                            title: Text(
                                'Cumpleaños de : ${alumno.nombre} ${alumno.apellido}'),
                            subtitle: Text(
                                'Fecha de Nacimiento: ${alumno.fechaNacimiento}'),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
