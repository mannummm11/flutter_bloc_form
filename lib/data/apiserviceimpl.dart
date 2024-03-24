import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterbloctutorial/data/entity/FoodReceipeModel.dart';
import 'package:http/http.dart';

import '../domain/apiservices.dart';
import 'APIS/endpoint.dart';

class APIServiceImp extends APIService {
  @override
  Future<List<FoodReceipeModel>> getFoodReceipe(String food) async {
    var response = await get(Uri.parse(searchRecipe(food)));
    Map result = await jsonDecode(response.body);
    List<dynamic> list = result['hits'];
    return list
        .map((e) => FoodReceipeModel(
            label: e['recipe']['label'],
            imageUrl: e['recipe']['image'],
            calories: e['recipe']['calories'],
            totalWeight: e['recipe']['totalWeight'],
            totalTime: e['recipe']['totalTime']))
        .toList();
  }
}
