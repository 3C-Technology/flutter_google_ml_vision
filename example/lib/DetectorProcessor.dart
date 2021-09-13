import 'dart:core';

import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:google_ml_vision_example/IngredentsName.dart';

class DetectorProcessor {
  List<String> arrayOfAllIngredients = IngredentsList.ingredentsName;

  List<String> resultIngredients = [];
  int sumOfIngredentDetect = 0;

  void updateResult(List<TextBlock> blocks) {
    if (blocks.isEmpty) {
      return;
    }
    int size = arrayOfAllIngredients.length;
    int sizeBlock = blocks.length;
    String compare = "";
    for (int j = 0; j < sizeBlock; j++) {
      if (blocks[j].text != null) {
        compare = compare + " " + blocks[j].text!;
      }
    }
    String blockIngredients = compare;
    for (int i = 0; i < size; i++) {
      String ingredientName = arrayOfAllIngredients[i];
      blockIngredients
          .replaceAll("-\n", "")
          .replaceAll("\n", " ")
          .replaceAll("\r", " ");
      if (blockIngredients.contains(ingredientName + ",") ||
          blockIngredients.contains(ingredientName + ".") ||
          blockIngredients.contains(ingredientName + " (and)")) {
        if (ifContains(
            resultIngredients, sumOfIngredentDetect, ingredientName)) {
          resultIngredients.add(ingredientName);
          sumOfIngredentDetect++;
        }
      }
    }
    print(blockIngredients);
  }

  bool ifContains(List<String> Ingredients, int number, String name) {
    bool result = false;
    for (int i = 0; i < number; i++) {
      if (Ingredients[i].contains(name)) {
        result = true;
        break;
      } else if (name.contains(Ingredients[i])) {
        resultIngredients[i] = name;
        result = true;
        break;
      }
    }
    return !result;
  }

  String result() {
    String result = "";
    resultIngredients.forEach((element) {
      result = result + element + ",";
    });
    return result;
  }
}
