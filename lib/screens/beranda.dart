import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yukbacaquran/globals.dart';
import 'package:yukbacaquran/screens/cari_lokasi.dart';
import 'package:yukbacaquran/screens/doa_screen.dart';
import 'package:yukbacaquran/screens/home_screen.dart';
import 'package:yukbacaquran/screens/prayer.dart';
import 'package:yukbacaquran/screens/tips_screen.dart';
import 'package:yukbacaquran/tabs/hijb_tab.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  int _currentIndex = 0;
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

  List<Widget> buildTabs() {
    if (idKota.isNotEmpty) {
      return [
        HomeScreen(),
        TipsScreen(),
        PrayerScreen(idKota: idKota),
        DoaScreen(),
        HijbTab(),
      ];
    } else {
      return [
        HomeScreen(),
        TipsScreen(),
        CariLokasiPage(), // Ganti dengan halaman yang sesuai jika idKota belum tersedia
        DoaScreen(),
        HijbTab(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = buildTabs();

    return Scaffold(
      backgroundColor: background,
      body: _tabs[_currentIndex], // Tampilkan tab yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomBarItem(icon: "assets/svg/quran-menu.svg", label: "Quran"),
          _bottomBarItem(icon: "assets/svg/lamp-menu.svg", label: "Tips"),
          _bottomBarItem(
              icon: idKota.isNotEmpty
                  ? "assets/svg/pray-menu.svg"
                  : "assets/svg/pray-menu.svg",
              label: "Prayer"),
          _bottomBarItem(icon: "assets/svg/doa-menu.svg", label: "Doa"),
          _bottomBarItem(
            icon: "assets/svg/bookmark-menu.svg",
            label: "Bookmark",
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomBarItem(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        color: text,
      ),
      activeIcon: SvgPicture.asset(
        icon,
        color: primary,
      ),
      label: label,
    );
  }
}
