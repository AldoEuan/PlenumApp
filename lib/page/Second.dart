import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plenumapp/model/expedientealumno.dart';
import 'dart:convert';
import 'package:plenumapp/page/ExpedienteAlumnoPage.dart';
import 'package:plenumapp/page/Principal.dart';
class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  String _apiToken = '';
  final _storage = const FlutterSecureStorage();
  // ignore: prefer_final_fields, unused_field
  int _selectedAlumnoId = 0;

  @override
  void initState() {
    super.initState();
    _getApiToken();
  }

  void _getApiToken() async {
    final token = await _storage.read(key: 'api_token');
    setState(() {
      _apiToken = token ?? '';
    });
  }

  void _getListNombresAlumnos() async {
    final url = Uri.parse('https://localhost:5001/api/V1/ExpedienteAlumno');

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

  List<ExpedienteAlumno> _alumnos = [];

  void _parseData(String responseBody) {
    final parsed = json.decode(responseBody);
    final alumnos = parsed['data'] as List<dynamic>;
    _alumnos =
        alumnos.map((alumno) => ExpedienteAlumno.fromJson(alumno)).toList();


    setState(() {});
  }

  void _saveAlumnoId(int id) async {
    await _storage.write(key: 'id_alumno', value: id.toString());
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
              const SizedBox(height:  50, ),
              ElevatedButton.icon(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Principal()));
              },
              label: const Text("Ver Cumpleaños"),
              icon: const Icon(Icons.calendar_month_rounded),
              ),
              Image.asset(
                'assets/CelulasPlenum_Negro.png',
                width: 200,
                height: 200,
              ),
              Text("Bienvenido al Sistema de Células Plenum Móvil",style: GoogleFonts.poppins(fontSize: 15,fontWeight:FontWeight.w700 ),),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.supervised_user_circle_rounded),
                    label: const Text("Ver lista de estudiantes"),
                    onPressed: _getListNombresAlumnos,
                  ),
                ],
              ),
              
              Expanded(
                child: ListView.builder(
                  itemCount: _alumnos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final alumno = _alumnos[index];
                    return ListTile(
                      title: Text(
                          'Alumno : ${alumno.nombre} ${alumno.apellido}'),
                      subtitle: Row(
                        children: [
                          Text('Ciclo: ${alumno.cicloPenumActual}'),
                          ElevatedButton.icon(
                            onPressed: () {
                              _saveAlumnoId(alumno.idAlumno);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpedienteAlumnoPage()));
                            },
                            label: const Text("Ver Expediente"),
                            icon: const Icon(Icons.archive_sharp),
                          ),
                        ],
                      ),
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
