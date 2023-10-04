import 'dart:convert';

List<PilihLokasi> pilihLokasiFromJson(String str) => List<PilihLokasi>.from(
    json.decode(str).map((x) => PilihLokasi.fromJson(x)));

String pilihLokasiToJson(List<PilihLokasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PilihLokasi {
  String id;
  String lokasi;

  PilihLokasi({
    required this.id,
    required this.lokasi,
  });

  factory PilihLokasi.fromJson(Map<String, dynamic> json) => PilihLokasi(
        id: json["id"],
        lokasi: json["lokasi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
      };
}
