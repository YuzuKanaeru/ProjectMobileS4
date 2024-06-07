class VotingResult {
  final String idKandidat;
  final String namaKetua;
  final String namaWakil;
  final int totalVote;

  VotingResult({
    required this.idKandidat,
    required this.namaKetua,
    required this.namaWakil,
    required this.totalVote,
  });

  factory VotingResult.fromJson(Map<String, dynamic> json) {
    return VotingResult(
      idKandidat: json['id_kandidat'],
      namaKetua: json['Nama_Ketua'],
      namaWakil: json['Nama_Wakil'],
      totalVote: json['total_vote'],
    );
  }
}
