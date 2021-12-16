 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/model/travel_model.dart';

class TravelProvider with ChangeNotifier {
  List<TravelModel> _travelList = [];

  List<TravelModel> get travelList => _travelList;

  Future<void> getTravelData() async {
    try {
      final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/araiara/34f9a2ac0d650d32df37dc50293f5f0e/raw/3a724db612f9b8ca9edd787497fe4e06077ab5d3/travel-app-list.json'  
      ));
      List<dynamic> responseList = jsonDecode(response.body);
      _travelList = List<TravelModel>.from(responseList.map((travel) => TravelModel.fromJson(travel)));

    }
    catch(error) {
      print(error);
    } 
  }

  TravelModel getTravelById(String id) {
    return _travelList.firstWhere((travel) => travel.id == id);
  }



  void toggleFavourite(String id) {
    int index = _travelList.indexWhere((element) => element.id == id);
    _travelList[index].isFavourite = !_travelList[index].isFavourite;
    notifyListeners();
  }


  List<TravelModel> getFavourites() {
    return _travelList.where((travel) => travel.isFavourite).toList();
  }

  List<TravelModel> getSearchResults(String query) {
    return _travelList
        .where((travel) =>
            travel.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
  }
}
