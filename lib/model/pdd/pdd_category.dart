// To parse this JSON data, do
//
//     final pddCategory = pddCategoryFromJson(jsonString);

import 'dart:convert';

List<PddCategory> pddCategoryFromJson(String str) => List<PddCategory>.from(json.decode(str).map((x) => PddCategory.fromJson(x)));

String pddCategoryToJson(List<PddCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PddCategory {
  PddCategory({
    required this.level,
    required this.name,
    required this.id,
    required this.parentId,
  });

  int level;
  String name;
  int id;
  int parentId;

  factory PddCategory.fromJson(Map<String, dynamic> json) => PddCategory(
    level: json["level"],
    name: json["name"],
    id: json["id"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "name": name,
    "id": id,
    "parentId": parentId,
  };
}
