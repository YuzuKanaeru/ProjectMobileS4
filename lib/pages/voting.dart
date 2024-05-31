import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Voting extends StatelessWidget {
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
            'Voting Kandidat',
            style: GoogleFonts.getFont(
              'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        padding: EdgeInsets.all(14),
        child: ListView.builder(
          itemCount: 3, // Ganti dengan jumlah kandidat yang sebenarnya
          itemBuilder: (context, index) {
            return buildCandidateCard();
          },
        ),
      ),
    );
  }

  Widget buildCandidateCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Color(0x800079FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Color(0xFFFFFFFF),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                'Nama Kandidat',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
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
    home: Voting(),
  ));
}
