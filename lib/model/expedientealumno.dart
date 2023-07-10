class ExpedienteAlumno{
  final int idAlumno;
  final String  nombre;
  final String  apellido;
  final String  correoPersonal;
  final String  correoInstitucional;
  final int cicloPenumActual;
  ExpedienteAlumno({
    required this.idAlumno,
    required this.nombre,
    required this.apellido,
    required this.correoPersonal,
    required this.correoInstitucional,
    required this.cicloPenumActual
  });

  factory ExpedienteAlumno.fromJson(Map<String, dynamic> json) {
    return ExpedienteAlumno(
      idAlumno: json['idAlumno'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      correoPersonal: json['correoPersonal'] ?? '',
      correoInstitucional: json['correoInstitucional'] ?? '',
      cicloPenumActual: json['cicloPenumActual'] ?? '',
    );
  }
}