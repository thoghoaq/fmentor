// To parse this JSON data, do
//
//     final specialty = specialtyFromJson(jsonString);

import 'dart:convert';

List<Specialty> specialtyFromJson(String str) =>
    List<Specialty>.from(json.decode(str).map((x) => Specialty.fromJson(x)));

String specialtyToJson(List<Specialty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Specialty {
  Specialty({
    required this.specialtyId,
    required this.name,
    required this.picture,
    required this.numberMentor,
  });

  int specialtyId;
  String name;
  String picture;
  int numberMentor;

  factory Specialty.fromJson(Map<String, dynamic> json) => Specialty(
        specialtyId: json["specialtyId"],
        name: json["name"],
        picture: json["picture"],
        numberMentor: json["numberMentor"],
      );

  Map<String, dynamic> toJson() => {
        "specialtyId": specialtyId,
        "name": name,
        "picture": picture,
        "numberMentor": numberMentor,
      };
}
