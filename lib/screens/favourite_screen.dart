import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/travel_provider.dart';
import 'package:travel_app/screens/travel_list_item.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favourites'),
        elevation: 0,
      ),
      body: Consumer<TravelProvider>(
        builder: (ctx, data, child) {
          final favourites = data.getFavourites();
          return favourites.isEmpty
            ? Center(child: Text('No favourites yet!'))
            : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ), 
              itemCount: favourites.length,
              itemBuilder: (ctx, index) {
                final travel = favourites[index];
                return TravelListItem(travel: travel,);
              },
            );
        }, 
      ),
    );
  }
}