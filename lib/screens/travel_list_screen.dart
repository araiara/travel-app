import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/model/travel_model.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/provider/travel_provider.dart';
import 'package:travel_app/screens/travel_list_item.dart';
import 'package:travel_app/screens/favourite_screen.dart';
import 'package:travel_app/screens/travel_search_delegate.dart';

class TravelListScreen extends StatefulWidget {
  const TravelListScreen({ Key key }) : super(key: key);

  @override
  _TravelListScreenState createState() => _TravelListScreenState();
}

class _TravelListScreenState extends State<TravelListScreen> {
  bool _isInit = true;
  Future _fetchData;

  Future<void> _getTravelData() async {
    try { 
      await Provider.of<TravelProvider>(context, listen: false).getTravelData();
    }
    catch(error) {
      print(error);
    } 
  }

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      if(_isInit) {
        _fetchData = _getTravelData();
      }

      _isInit = false;
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel App'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 30),
            onPressed: () {
              showSearch(context: context, delegate: TravelSearchDelegate());
            }
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, size: 30),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => FavouriteScreen()));
            }
          )
        ],
      ),
      body: FutureBuilder(
        future: _fetchData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          return snapshot.connectionState == ConnectionState.waiting 
            ? Center(child: CircularProgressIndicator()) 
            : Consumer<TravelProvider>(
              builder: (ctx, data, child) {
                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ), 
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    final travel = data.travelList[index];
                    return TravelListItem(travel: travel,);
                  },
                );
              }, 
            );
        },
      ),
    );
  }
}