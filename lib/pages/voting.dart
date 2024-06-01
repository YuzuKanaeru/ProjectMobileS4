import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/model/kandidat.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  Future<List<Kandidat>> fetchKandidat() async {
    final response =
        await http.get(Uri.parse('https://vote.sipkopi.com/api/kandidat/tampil'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> kandidatList = data['Data Kandidat'];
      return kandidatList.map((json) => Kandidat.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load kandidat');
    }
  }

  Future<void> _confirmVote(Kandidat kandidat) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Yakin ingin memilih kandidat ini?'),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(false); // Close dialog and return false
              },
            ),
            TextButton(
              child: Text('Iya'),
              onPressed: () {
                Navigator.of(context).pop(true); // Close dialog and return true
                _voteForCandidate(kandidat); // Call function to vote for candidate
              },
            ),
          ],
        );
      },
    );

    if (confirm != null && confirm) {
      // Perform action if user confirms
      // For example, send voting data to API
      print('Vote for ${kandidat.namaKetua}');
    }
  }

  Future<void> _voteForCandidate(Kandidat kandidat) async {
    // Simulate voting process
    await Future.delayed(Duration(seconds: 2));

    // Navigate back to dashboard after voting
    Navigator.pushNamedAndRemoveUntil(
        context, '/dashboard', (Route<dynamic> route) => false);
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (Route<dynamic> route) => false);
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
        child: FutureBuilder<List<Kandidat>>(
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Kandidat kandidat = snapshot.data![index];
                  return GestureDetector(
                    onTap: () => _confirmVote(kandidat),
                    child: buildCandidateCard(kandidat),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildCandidateCard(Kandidat kandidat) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.only(bottom: 32),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(0, 4),
              blurRadius: 2,
            ),
          ],
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(kandidat.gambar),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kandidat.namaKetua,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${kandidat.namaWakil}',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
