import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/data/entity/shelter.dart';
import '../../core/data/repository/user_repository.dart';

/// A single shelter row.
class ShelterItem extends StatelessWidget {
  const ShelterItem(this.shelter, this.reference, {super.key});

  final Shelter shelter;
  final DocumentReference<Shelter> reference;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          photoURL,
          Flexible(child: details),
        ],
      ),
    );
  }

  /// Returns the shelter photo.
  Widget get photoURL {
    return SizedBox(
      width: 100,
      child: Image.network(shelter.photoURL!),
    );
  }

  /// Returns shelter details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name,
          locationData,
          distance,
        ],
      ),
    );
  }

  ///Returns distance between Shelter and User.
  get distance async {
    Position userPosition = await UserRepository().getLocation();
    print('Kullanıcının konumu: ${userPosition.latitude}, ${userPosition.longitude}');

    return calculateDistance(userPosition,
        shelter.coordinates!.latitude,
        shelter.coordinates!.longitude);
  }

  Future<double> calculateDistance(
      Position userPosition,
      double shelterLatitude,
      double shelterLongitude) async {
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
        shelterLatitude,
      shelterLongitude,
    );

    double distanceInKilometers = distanceInMeters / 1000; // Metreden kilometreye dönüştürme

    return distanceInKilometers;
  }

  /// Return the shelter name.
  Widget get name {
    return Text(
      '${shelter.name}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns metadata about the shelter.
  Widget get locationData {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('Rated: ${shelter.city}'),
          ),
          Text('Runtime: ${shelter.coordinates}'),
        ],
      ),
    );
  }

  /// Returns a list of genre shelter tags.
  /* List<Widget> get genreItems {
    return [
      for (final genre in shelter.genre)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            label: Text(
              genre,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
    ];
  } */

  /// Returns all genres.
/*  Widget get genres {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        children: genreItems,
      ),
    );
  }*/
}