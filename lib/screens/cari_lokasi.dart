import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukbacaquran/globals.dart';
import 'package:yukbacaquran/models/lokasi.dart';
import 'package:yukbacaquran/screens/prayer.dart';

class CariLokasiPage extends StatefulWidget {
  @override
  _CariLokasiPageState createState() => _CariLokasiPageState();
}

class _CariLokasiPageState extends State<CariLokasiPage> {
  List<PilihLokasi> lokasiList = [];
  TextEditingController searchController = TextEditingController();
  List<PilihLokasi> filteredLokasiList = [];

  @override
  void initState() {
    super.initState();
    loadLokasiData();
  }

  Future<void> loadLokasiData() async {
    // Gantilah 'lokasi.json' dengan lokasi file JSON Anda
    final String lokasiJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/lokasi.json');
    final List<dynamic> lokasiJson = json.decode(lokasiJsonString);
    setState(() {
      lokasiList =
          lokasiJson.map((data) => PilihLokasi.fromJson(data)).toList();
      filteredLokasiList = lokasiList;
    });
  }

  void filterLokasi(String query) {
    setState(() {
      filteredLokasiList = lokasiList
          .where((lokasi) =>
              lokasi.lokasi.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background, // Ubah warna latar belakang
      appBar: _appBar(),
      body: Padding(
        // Tambahkan Padding di sini
        padding:
            const EdgeInsets.all(16.0), // Atur padding sesuai kebutuhan Anda
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    filterLokasi(value);
                  },
                  style: const TextStyle(
                      color: Colors.white), // Ubah warna teks input
                  decoration: const InputDecoration(
                    labelText: 'Cari Lokasi',
                    labelStyle: TextStyle(
                        color: Colors.white), // Ubah warna label (Cari Lokasi)
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white, // Ubah warna ikon search
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final lokasi = filteredLokasiList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _saveIdKota(lokasi.id);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrayerScreen(
                                  idKota: lokasi.id,
                                  showCustomBackButton: true),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            lokasi.lokasi,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        // Tambahkan Padding di sini
                        padding: const EdgeInsets.symmetric(
                            horizontal:
                                16.0), // Atur margin horizontal pada Divider
                        child: Divider(
                          height: 1,
                          color: const Color(0xFF7B80AD).withOpacity(.35),
                        ),
                      ),
                    ],
                  );
                },
                childCount: filteredLokasiList.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(children: [
          IconButton(
            onPressed: (() => {}),
            icon: SvgPicture.asset('assets/svg/menu-icon.svg'),
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            'Cari Wilayah',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white, // Ubah warna teks appbar
            ),
          ),
        ]),
      );

  Future<void> _saveIdKota(String idKota) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('idKota', idKota);
  }
}
