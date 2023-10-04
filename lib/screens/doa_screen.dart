import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yukbacaquran/models/doa.dart';

class DoaScreen extends StatefulWidget {
  @override
  _DoaScreenState createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  List<Doa> doaList = [];
  List<String> dropdownItems = [];
  String selectedAyatLatin = "";
  String selectedArti = "";

  @override
  void initState() {
    super.initState();
    loadDoaData();
  }

  Future<void> loadDoaData() async {
    final doaJsonString = await rootBundle.loadString('assets/data/doa.json');
    final doaJson = json.decode(doaJsonString);

    setState(() {
      doaList = doaFromJson(doaJson);
      dropdownItems = doaList.map((doa) => doa.doa).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa List'),
      ),
      body: ListView.builder(
        itemCount: doaList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doaList[index].doa),
            onTap: () {
              setState(() {
                selectedAyatLatin = doaList[index].latin;
                selectedArti = doaList[index].artinya;
              });

              // Show a dialog with the selected ayat Latin and arti
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Ayat Latin dan Arti"),
                    content: Column(
                      children: [
                        Text("Ayat Latin: $selectedAyatLatin"),
                        Text("Arti: $selectedArti"),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tutup"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
