import 'package:flutter/material.dart';
import 'package:travel_app/model/travel_model.dart';
import 'package:travel_app/screens/travel_detail_screen.dart';

class TravelListItem extends StatelessWidget {
  final TravelModel travel;
  const TravelListItem({ Key key, this.travel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => TravelDetailScreen(
              id: travel.id,
            ))
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Image.network(
                travel.imageUrl,
                height: 150,
              ),
              Text(travel.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15
                ),
              ),
            ],
          ),
        ),
      ),
    );                  
  }
}