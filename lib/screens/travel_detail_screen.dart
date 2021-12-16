import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/provider/travel_provider.dart';

class TravelDetailScreen extends StatelessWidget {
  final String id;
  const TravelDetailScreen({ Key key, this.id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDestination = Provider.of<TravelProvider>(context, listen: false).getTravelById(id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Consumer<TravelProvider>(
            builder: (BuildContext context, data, Widget child) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    selectedDestination.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: selectedDestination.isFavourite
                        ? Colors.red
                        : Colors.black,
                  ),
                  iconSize: 28,
                  onPressed: () {
                    data.toggleFavourite(selectedDestination.id);
                  },
                ),
              );
            },            
          ),
        ],
      ),
      body: Column (
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(selectedDestination.name,
                  style: TextStyle (
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(selectedDestination.id,
                  style: TextStyle (
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  selectedDestination.imageUrl,
                  height: 200,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(selectedDestination.description, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,),
                  ),                  
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Speciality: " + selectedDestination.speciality, textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Reviews: " + selectedDestination.review.toString(), textAlign: TextAlign.left, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          )

        ],
      )
    );
  }
}