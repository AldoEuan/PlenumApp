class Alumno {
  final int id;
  final String nombre;
  final String apellido;
  final String fechaNacimiento;
  final String direccion;
  final String celularPersonal;
  final String correoPersonal;
  final String matricula;
  final String correoInstitucional;

  Alumno({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.fechaNacimiento,
    required this.direccion,
    required this.celularPersonal,
    required this.correoPersonal,
    required this.matricula,
    required this.correoInstitucional,
  });

  factory Alumno.fromJson(Map<String, dynamic> json) {
    return Alumno(
      id: json['idAlumnoDual'] ?? 0,
      nombre: json['nombreAlumnoDual'] ?? '',
      apellido: json['apellidoAlumnoDual'] ?? '',
      fechaNacimiento: json['fechaNacimiento'] ?? '',
      direccion: json['direccion'] ?? '',
      celularPersonal: json['celularPersonal'] ?? '',
      correoPersonal: json['correoPersonal'] ?? '',
      matricula: json['matricula'] ?? '',
      correoInstitucional: json['correoInstitucional'] ?? '',
    );
  }
}
