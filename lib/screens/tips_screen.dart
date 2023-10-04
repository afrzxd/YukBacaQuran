import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yukbacaquran/globals.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: background,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                IconButton(
                  onPressed: (() => {}),
                  icon: SvgPicture.asset('assets/svg/menu-icon.svg'),
                ),
                const SizedBox(
                  width: 24,
                ),
                Text(
                  'Tips',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24), // Add horizontal padding here
                  child: _hadist(),
                ),

                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: grey, // Warna latar belakang
                    borderRadius: BorderRadius.circular(
                        10), // BorderRadius sesuai kebutuhan Anda
                  ),
                  padding: const EdgeInsets.all(2), // Padding untuk teks judul
                  child: Text(
                    "Judul",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ), // Add more widgets or content here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _hadist() {
    return Stack(
      children: [
        Container(
          height: 121,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0,
                .6,
                1,
              ],
              colors: [
                Color(0xFF0B0115),
                Color(0xFF3B1E77),
                Color(0xFF240F4F),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'ِاقْرَأُوْا القُرْآنَ فَإِنَّهُ يَأْتِيْ يَوْمَ القِيَامَةِ شَفِيْعًا لِأَصْحَابِه',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Bacalah Al Qur’an, karena ia akan datang pada hari kiamat\n sebagai syafa’at bagi shahibul Qur’an\n (HR. Muslim : 804)',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
