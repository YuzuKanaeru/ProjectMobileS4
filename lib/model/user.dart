class User {
  final String nisNip;
  final String namaLengkap;
  final String jenisKelamin;
  final String kelas;
  final String idPosisi;
  final String status;
  final String pass;
  final String? qr;

  User({
    required this.nisNip,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.kelas,
    required this.idPosisi,
    required this.status,
    required this.pass,
    this.qr,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nisNip: json['nis_nip'],
      namaLengkap: json['nama_lengkap'],
      jenisKelamin: json['jenis_kelamin'],
      kelas: json['kelas'],
      idPosisi: json['id_posisi'],
      status: json['status'],
      pass: json['pass'],
      qr: json['qr'],
    );
  }
}
