import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaftarKandidat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0079FB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCard(),
              SizedBox(height: 20),
              buildCard(),
              SizedBox(height: 20),
              buildCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard() {
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
              color: Colors.grey[300],
            ),
            SizedBox(height: 10),
            Text(
              'Nama Kandidat',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Visi',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Misi',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              '"Misi kami adalah mengembangkan dan menyebarkan teknologi terbaru yang membantu mengurangi jejak karbon, meningkatkan efisiensi sumber daya, dan mendukung keberlanjutan lingkungan."',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 5),
            Text(
              '"Menjadi pionir dalam solusi teknologi hijau yang memungkinkan transisi menuju dunia yang lebih berkelanjutan dan ramah lingkungan."',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w400,
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
