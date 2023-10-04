import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijriyah_indonesia/hijriyah_indonesia.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukbacaquran/globals.dart';
import 'package:yukbacaquran/screens/beranda.dart';

class PrayerScreen extends StatefulWidget {
  final String idKota;
  final bool showCustomBackButton;

  PrayerScreen({required this.idKota, this.showCustomBackButton = false});

  @override
  _PrayerScreenState createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  String idKota = '';

  @override
  void initState() {
    super.initState();
    _loadIdKota();
  }

  Future<void> _loadIdKota() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIdKota = prefs.getString('idKota');
    if (savedIdKota != null) {
      setState(() {
        idKota = savedIdKota;
      });
    }
  }

  String _getHijriDate() {
    var _today = Hijriyah.now();
    String hijriDate =
        "${_today.hDay} ${_today.getLongMonthName()} ${_today.hYear} Hijriyah";
    return hijriDate;
  }

  // Add this GridView as a separate method
  GridView _prayerTimesGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        String prayerName = '';
        String iconPath = '';
        String prayerTime = '';

        switch (index) {
          case 0:
            prayerName = 'Shubuh';
            iconPath = 'assets/svg/shubuh.svg';
            prayerTime = '05:30';
            break;
          case 1:
            prayerName = 'Dhuha';
            iconPath = 'assets/svg/dhuha.svg';
            prayerTime = '07:00';
            break;
          case 2:
            prayerName = 'Dzuhur';
            iconPath = 'assets/svg/dzuhur.svg';
            prayerTime = '12:00';
            break;
          case 3:
            prayerName = 'Ashar';
            iconPath = 'assets/svg/ashar.svg';
            prayerTime = '15:30';
            break;
          case 4:
            prayerName = 'Magrib';
            iconPath = 'assets/svg/magrib.svg';
            prayerTime = '18:00';
            break;
          case 5:
            prayerName = 'Isya';
            iconPath = 'assets/svg/isya.svg';
            prayerTime = '19:30';
            break;
        }

        return Column(
          children: [
            Text(
              prayerName,
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: text,
              ),
            ),
            SvgPicture.asset(
              iconPath,
              width: 19,
              height: 19,
              color: Colors.white,
            ),
            Text(
              prayerTime,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: text,
              ),
            ),
          ],
        );
      },
    );
  }

  Column _greeting() {
    String hijriDate = _getHijriDate();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hijriDate,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: text,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Yuk Baca Quran',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        // Add the prayer times grid
        _prayerTimesGridView(),
      ],
    );
  }

  AppBar _appBar() => AppBar(
        backgroundColor: background,
        elevation: 0,
        title: Row(children: [
          if (widget.showCustomBackButton)
            IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>
                        BerandaPage(), // Ganti dengan BerandaScreen
                  ),
                  (route) => false,
                );
              },
              icon: SvgPicture.asset('assets/svg/back.svg'),
            ),
          IconButton(
            onPressed: (() => {}),
            icon: SvgPicture.asset('assets/svg/menu-icon.svg'),
          ),
          const SizedBox(
            width: 24,
          ),
          Text(
            'Jadwal Sholat',
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: _greeting(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
