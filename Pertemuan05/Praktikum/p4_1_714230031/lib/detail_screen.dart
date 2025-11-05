import 'package:flutter/material.dart';
import 'model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  const DetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    var iniFontStaatliches = const TextStyle(fontFamily: 'Staatliches');

    return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(place.imageAsset),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back), 
                    color: Colors.white,
                    onPressed: () {
                    Navigator.pop(context);
                  },
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Text(
            place.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Staatliches',
            ),
          ),
        ),
      
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children:  <Widget>[
                  Icon(Icons.calendar_today, color: Colors.green,),
                  SizedBox(height: 8.0),                  
                  Text(
                    //Open Day
                    place.openDays,
                    style: iniFontStaatliches,
                  ),
                ],
              ),
      
              Column(
                children:  <Widget>[
                  Icon(Icons.access_time, color: Colors.green,),
                  Text(
                    //Open Time
                    place.openTime,
                    style: iniFontStaatliches,
                    ),
                ],
              ),
      
              Column(
                children:  <Widget>[
                  Icon(Icons.monetization_on, color: Colors.green,),
                  Text(
                    //Tiket Price
                    place.ticketPrice,
                    style: iniFontStaatliches,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            place.description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.deepPurpleAccent,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: place.imageUrls.map((url) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(url, fit: BoxFit.cover),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
      ),
    ),
    );
  }
}