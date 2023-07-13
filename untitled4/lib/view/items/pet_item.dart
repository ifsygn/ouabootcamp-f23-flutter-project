import 'package:flutter/material.dart';
import '../../core/data/entity/pet.dart';

class PetItem extends StatelessWidget {
  final Pet pet;

  const PetItem({Key? key,
    required this.pet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: photoURL,
      title: name,
      subtitle: age,
    );
  }

  /// Return the pet name.
  Widget get name {
    return Text(
      '${pet.name}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Return the pet age.
  Widget get age {
    return Text(
      '${pet.age}',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns the pet photo.
  Widget get photoURL {
    return SizedBox(
      width: 100,
      child: Image.network(pet.photoURL!),
    );
  }

  /*
  /// Returns pet details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          name,
        ],
      ),
    );
  }
  */
}