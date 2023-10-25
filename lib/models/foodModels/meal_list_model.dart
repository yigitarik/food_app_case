import 'package:food_mood/models/foodModels/meal_model.dart';

class MealListModel {
  List<Meals> meals = [];

  MealListModel({required this.meals});

  MealListModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals.add(Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meals'] = meals.map((v) => v.toJson()).toList();
    return data;
  }
}
