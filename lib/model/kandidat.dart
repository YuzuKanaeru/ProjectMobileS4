class Kandidat {
  final String id;
  final String visi;
  final String misi;
  final String namaKetua;
  final String namaWakil;
  final String gambar;

  Kandidat({
    required this.id,
    required this.visi,
    required this.misi,
    required this.namaKetua,
    required this.namaWakil,
    required this.gambar,
  });

  factory Kandidat.fromJson(Map<String, dynamic> json) {
    return Kandidat(
      id: json['id_kandidat'],
      visi: json['visi'],
      misi: json['misi'],
      namaKetua: json['nama_ketua'],
      namaWakil: json['nama_wakil'],
      gambar: json['gambar'],
    );
  }
}
