class expedienteAIndividual {
  final int id;
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final String dirreccion;
  final String celularPersonal;
  final String correoPersonal;
  final String telefono;
  final String matricula;
  final String correoInstitucional;
  final int cicloPlenumInscripcion;
  final int ingresoEscolarSemestre;
  final String fechaInicioPlenum;
  final String? fechaFinalPlenum;
  final int numeroGeneracionPlenum;
  final String correoPlenum;
  final String nombreEmergencia;
  final String parentescoEmergencia;
  final String celularEmergencia;
  final String telefonoEmergencia;
  final String? fechaBaja;
  final String? motivoBaja;
  final String observacionesGenerales;
  final int idCarrera;
  final int idUsuario;
  final int idInstitucion;
  final String nombreEstadoEscolar;

  expedienteAIndividual({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.dirreccion,
    required this.celularPersonal,
    required this.correoPersonal,
    required this.telefono,
    required this.matricula,
    required this.correoInstitucional,
    required this.cicloPlenumInscripcion,
    required this.ingresoEscolarSemestre,
    required this.fechaInicioPlenum,
    this.fechaFinalPlenum,
    required this.numeroGeneracionPlenum,
    required this.correoPlenum,
    required this.nombreEmergencia,
    required this.parentescoEmergencia,
    required this.celularEmergencia,
    required this.telefonoEmergencia,
    this.fechaBaja,
    this.motivoBaja,
    required this.observacionesGenerales,
    required this.idCarrera,
    required this.idUsuario,
    required this.idInstitucion,
    required this.nombreEstadoEscolar,
  });

  factory expedienteAIndividual.fromJson(Map<String, dynamic> json) {
    return expedienteAIndividual(
      id: json['idAlumnoDual'] ?? 0,
      nombre: json['nombreAlumnoDual'] ?? '',
      apellido: json['apellidoAlumnoDual'] ?? '',
      fechaNacimiento: json['fechaNacimiento'] ?? '',
      dirreccion: json['dirreccion'] ?? '',
      celularPersonal: json['celularPersonal'] ?? '',
      correoPersonal: json['correoPersonal'] ?? '',
      telefono: json['telefono'] ?? '',
      matricula: json['matricula'] ?? '',
      correoInstitucional: json['correoInstitucional'] ?? '',
      cicloPlenumInscripcion: json['cicloPlenumInscripcion'] ?? 0,
      ingresoEscolarSemestre: json['ingresoEscolarSemestre'] ?? 0,
      fechaInicioPlenum: json['fechaInicioPlenum'] ?? '',
      fechaFinalPlenum: json['fechaFinalPlenum'],
      numeroGeneracionPlenum: json['numeroGeneracionPlenum'] ?? 0,
      correoPlenum: json['correoPlenum'] ?? '',
      nombreEmergencia: json['nombreEmergencia'] ?? '',
      parentescoEmergencia: json['parentescoEmergencia'] ?? '',
      celularEmergencia: json['celularEmergencia'] ?? '',
      telefonoEmergencia: json['telefonoEmergencia'] ?? '',
      fechaBaja: json['fechaBaja'],
      motivoBaja: json['motivoBaja'],
      observacionesGenerales: json['observacionesGenerales'] ?? '',
      idCarrera: json['idCarrera'] ?? 0,
      idUsuario: json['idUsuario'] ?? 0,
      idInstitucion: json['idInstitucion'] ?? 0,
      nombreEstadoEscolar: json['nombreEstadoEscolar'] ?? '',
    );
  }
}
