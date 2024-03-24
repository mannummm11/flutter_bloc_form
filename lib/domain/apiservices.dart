import 'dart:convert';

import 'package:flutterbloctutorial/data/APIS/endpoint.dart';
import 'package:http/http.dart';

import '../data/entity/FoodReceipeModel.dart';

abstract class APIService {
  Future<List<FoodReceipeModel>> getFoodReceipe(String food);
}