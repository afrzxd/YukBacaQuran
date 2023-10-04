import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yukbacaquran/globals.dart';
import 'package:yukbacaquran/models/surah.dart';
import 'package:yukbacaquran/screens/detail_screen.dart';

class PageTab extends StatefulWidget {
  const PageTab({super.key});

  @override
  State<PageTab> createState() => _PageTabState();
}

class _PageTabState extends State<PageTab> with WidgetsBindingObserver {
  late List<Surah> surahList = [];
  late AudioPlayer splayer;
  int? currentlyPlayingIndex; // Index of currently playing audio

  @override
  void initState() {
    super.initState();
    splayer = AudioPlayer();
    _getSurahList();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this); // Hapus observer saat widget di-dispose
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      // Aplikasi tidak aktif (keluar atau restart), hentikan audio
      splayer.stop();
      setState(() {
        currentlyPlayingIndex = null;
      });
    }
  }

  Future<void> _getSurahList() async {
    String data = await rootBundle.loadString('assets/data/list-surah.json');
    surahList = surahFromJson(data);
    setState(() {});
  }

  void playAudio(String url, int index) async {
    if (currentlyPlayingIndex != null) {
      // Stop the previously playing audio
      await splayer.stop();
    }
    await splayer.play(UrlSource(url));
    setState(() {
      currentlyPlayingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          _surahItem(context: context, surah: surahList[index], index: index),
      separatorBuilder: (context, index) =>
          Divider(color: const Color(0xFF7B80AD).withOpacity(.35)),
      itemCount: surahList.length,
    );
  }

  Widget _surahItem({
    required Surah surah,
    required BuildContext context,
    required int index,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
              noSurat: surah.nomor,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  SvgPicture.asset('assets/svg/number.svg'),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Center(
                      child: Text(
                        "${surah.nomor}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Syekh Misyari Rashid Al Afasi",
                          style: GoogleFonts.poppins(
                            color: text,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  currentlyPlayingIndex == index
                      ? Icons.pause_circle_outline
                      : Icons.play_arrow_outlined,
                  color: Colors.white,
                ),
                iconSize: 32,
                onPressed: () {
                  if (currentlyPlayingIndex == index) {
                    // If the same audio is tapped again, pause it
                    splayer.pause();
                    setState(() {
                      currentlyPlayingIndex = null;
                    });
                  } else {
                    playAudio(surah.audio, index);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
