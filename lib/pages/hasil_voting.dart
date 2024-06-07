import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_app/model/votingresult.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<VotingResult>> fetchVotingResults() async {
  final response = await http.get(Uri.parse('https://sivosis.my.id/api/voting/total'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final votingData = data['Data Voting'] as List;
    return votingData.map((json) => VotingResult.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load voting results');
  }
}

class HasilVoting extends StatelessWidget {
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
            'Hasil Voting',
            style: GoogleFonts.getFont(
              'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<VotingResult>>(
        future: fetchVotingResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final results = snapshot.data!;
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                padding: EdgeInsets.fromLTRB(20, 30, 20, 152),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: results.map((result) {
                            return PieChartSectionData(
                              color: getColor(result.idKandidat),
                              value: result.totalVote.toDouble(),
                              title: '${result.totalVote}',
                              radius: 50,
                              titleStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ...results.map((result) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              color: getColor(result.idKandidat),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${result.namaKetua} & ${result.namaWakil}',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Color getColor(String idKandidat) {
    switch (idKandidat) {
      case '1':
        return Color(0xFFFF0000);
      case '2':
        return Color(0xFFFBE200);
      case '3':
        return Color(0xBF24FF00);
      default:
        return Colors.grey;
    }
  }
}