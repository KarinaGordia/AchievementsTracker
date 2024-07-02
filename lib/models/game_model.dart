import 'package:achievements/models/models.dart';

class GameModel {
  final int id;
  final String name;
  final String imageName;
  final String iconName;
  final List<WishModel> wishes;
  final Map<String, ExpansionPackModel> expansionPacks;

  GameModel({
    required this.wishes,
    required this.expansionPacks,
    required this.id,
    required this.name,
    required this.imageName,
    required this.iconName,
  });
}