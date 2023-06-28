import 'package:flutter/material.dart';
import 'package:untitled4/core/data/repository/shelter_repository.dart';
import '../../core/data/entity/shelter.dart';

class ShelterViewModel extends ChangeNotifier {

  final ShelterRepository _shelterRepository = ShelterRepository();
  Future<List<Shelter>> get shelters => _shelterRepository.getShelters();

  //verileri alarak widget'in state'ini günceller ve yeniden oluşturulmasını sağlar.
  // Böylece, güncel veriler arayüze yansır.
  Future<void> fetchShelters() async {
    await _shelterRepository.getShelters();
    notifyListeners();
  }
}