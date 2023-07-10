import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:plenumapp/model/expedienteAIndividual.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ExpedienteAlumnoPage extends StatefulWidget {
  const ExpedienteAlumnoPage({Key? key});

  @override
  State<ExpedienteAlumnoPage> createState() => _ExpedienteAlumnoStatePage();
}

class _ExpedienteAlumnoStatePage extends State<ExpedienteAlumnoPage> {
  final _storage = const FlutterSecureStorage();
  late int _alumnoId;
  expedienteAIndividual? _alumno;

  @override
  void initState() {
    super.initState();
    _getAlumnoId();
  }

  Future<void> _getAlumnoId() async {
    final idAlumno = await _storage.read(key: 'id_alumno');
    setState(() {
      _alumnoId = int.tryParse(idAlumno ?? '') ?? 0;
    });

    if (_alumnoId != 0) {
      await _fetchAlumnoData();
    }
  }

  Future<void> _fetchAlumnoData() async {
    final url = Uri.parse(
        'https://localhost:5001/api/V1/ExpedienteAlumno?idalumno=$_alumnoId');

    final headers = {
      'Authorization': 'Bearer ${await _storage.read(key: 'api_token')}',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final alumnosData = jsonResponse['data'] as List<dynamic>;

      if (alumnosData.isNotEmpty) {
        final alumnoData =
            alumnosData[0]; // Obtener el primer elemento de la lista

        setState(() {
          _alumno = expedienteAIndividual.fromJson(alumnoData);
        });
      }
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expediente del alumno ${_alumno!.nombre}'),
        backgroundColor: Colors.black
      ),
      body: Center(
        child: _alumno != null
            ? ListView(
                children: [
                  Card(
                    elevation: 5,
                    color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("Datos Generales",style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w800,color: Colors.white),),
                          Image.network("https://cdn-icons-png.flaticon.com/512/2345/2345409.png",width: 100, height: 100,),
                          const SizedBox(height:  50, ),
                          Text('Nombre: ${_alumno!.nombre}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Correo: ${_alumno!.correoPersonal}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Celular: ${_alumno!.celularPersonal}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Fecha de Nacimiento: ${_alumno!.fechaNacimiento}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Dirección: ${_alumno!.dirreccion}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Numero de Generacion Plenum: ${_alumno!.numeroGeneracionPlenum}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text( 'Ciclo Actual Plenum: ${_alumno!.cicloPlenumInscripcion}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Fecha de Inicio Plenum: ${_alumno!.fechaInicioPlenum}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.purple,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("Contacto de Emergencia",style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w800,color: Colors.white),),
                          Image.network("https://cdn-icons-png.flaticon.com/512/2556/2556946.png",width: 100, height: 100,),
                          const SizedBox(height:  50, ),
                          Text('Nombre: ${_alumno!.nombreEmergencia}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Parentesco: ${_alumno!.parentescoEmergencia}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Celular: ${_alumno!.celularEmergencia}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Telefono: ${_alumno!.telefonoEmergencia}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.green,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("Datos Escolares",style: GoogleFonts.poppins(fontSize: 23,fontWeight: FontWeight.w800,color: Colors.white),),
                          Image.network("https://cdn-icons-png.flaticon.com/512/3558/3558074.png",width: 100, height: 100,),
                          const SizedBox(height:  50, ),
                          Text('Matricula: ${_alumno!.matricula}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Correo Institucional: ${_alumno!.correoInstitucional}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Ingreso Actual: ${_alumno!.ingresoEscolarSemestre}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                          Text('Estado Escolar: ${_alumno!.nombreEstadoEscolar}',style: GoogleFonts.montserrat(color: Colors.white),),
                          const SizedBox(height:  25, ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}

