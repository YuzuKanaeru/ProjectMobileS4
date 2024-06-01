import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/model/kandidat.dart';

class DaftarKandidat extends StatefulWidget {
  @override
  _DaftarKandidatState createState() => _DaftarKandidatState();
}

class _DaftarKandidatState extends State<DaftarKandidat> {
  Future<List<Kandidat>> fetchKandidat() async {
    final response = await http.get(Uri.parse('https://vote.sipkopi.com/api/kandidat/tampil'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> kandidatList = data['Data Kandidat'];
      return kandidatList.map((json) => Kandidat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load kandidat');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0079FB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (Route<dynamic> route) => false);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Daftar Kandidat',
            style: GoogleFonts.getFont(
              'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Kandidat>>(
        future: fetchKandidat(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Found'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(14),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Kandidat kandidat = snapshot.data![index];
                return buildCard(kandidat);
              },
            );
          }
        },
      ),
    );
  }

  Widget buildCard(Kandidat kandidat) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(kandidat.gambar),
                ),
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nama Ketua: ${kandidat.namaKetua}',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            Text(
              'Nama Wakil: ${kandidat.namaWakil}',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Visi: ${kandidat.visi}',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Misi: ${kandidat.misi}',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DaftarKandidat(),
  ));
}
