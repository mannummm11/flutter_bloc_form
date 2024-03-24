import 'package:flutterbloctutorial/constants/constants.dart';

String searchRecipe(type) {
  return "https://api.edamam.com/search?q=$type&app_id=$appId&app_key=$appKey";
}
