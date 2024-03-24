import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class FoodReceipeModel {
  @required String imageUrl;
  @required double calories;
  @required double totalWeight;
  @required double totalTime;
  @required String label;
  bool isSelected;

  FoodReceipeModel({required this.label, required this.imageUrl, required this.calories, required this.totalWeight, required this.totalTime, this.isSelected = false});
}