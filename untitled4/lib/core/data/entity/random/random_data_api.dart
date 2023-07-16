import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../../../../common/helper/util/random_util.dart';
import '../../repository/pet_repository.dart';
import '../../repository/shelter_repository.dart';
import '../../repository/user_repository.dart';
import '../pet.dart';
import '../shelter.dart';
import '../users.dart';

final random = Random();
UserRepository userRepository = UserRepository();
ShelterRepository shelterRepository = ShelterRepository();
PetRepository petRepository = PetRepository();

class RandomDataApi {

  static Future<void> getRandomUser() async {
    try {
      final responseRandomUser = await http.get(Uri.parse('https://random-data-api.com/api/users/random_user'));
      if (responseRandomUser.statusCode == 200) {
        final jsonData = json.decode(responseRandomUser.body);
        final userJson = jsonData as Map<String, dynamic>;

        Users user = Users(
          id: userJson['uid'],
          email: userJson['email'],
          password: userJson['password'],
          // photoURL: userJson['avatar'] as List<String>,
          phoneNumber: userJson['phone_number'],
          name: userJson['first_name'],
          surName: userJson['last_name'],
        );

        userRepository.addUserWithConverter(user.id, user);
      } else {
        print('Request failed with status: ${responseRandomUser.statusCode}');
      }
    } catch (err) {
      print('Error: $err');
    }
  }

  static Future<void> getRandomShelter() async {
    try {
      final responseBank = await http.get(Uri.parse('https://random-data-api.com/api/v2/banks'));
      final responseAddress = await http.get(Uri.parse('https://random-data-api.com/api/v2/addresses'));
      if (responseBank.statusCode == 200 && responseAddress.statusCode == 200) {
        final jsonBankData = json.decode(responseBank.body);
        final BankJson = jsonBankData as Map<String, dynamic>;

        final jsonAddressData = json.decode(responseAddress.body);
        final AddressJson = jsonAddressData as Map<String, dynamic>;

        Shelter shelter = Shelter(
          id: BankJson['uid'],
          iBAN: BankJson['iban'],
          name: BankJson['bank_name'],
          city: AddressJson['city'],
          fullAddress: AddressJson['full_address'],
          state: AddressJson['state'],
          country: AddressJson['country'],
        );

        shelterRepository.addShelterWithConverter(shelter.id, shelter);
      } else {
        print('Request failed with status: ${responseBank.statusCode}');
      }
    } catch (err) {
      print('Error: $err');
    }
  }

  static Future<void> getRandomPet() async {
    try {
      // bool randomPet = random.nextBool();
      bool randomPet = true;
      String randomID = RandomUtil.generateRandomString(10);
      int randomAge = RandomUtil.generateRandomNumber(20);
      Response responseDog;
      Response responseCat;
      var dogJson;
      var CatJson;
      Pet pet;
      var headers = {
        'X-Api-Key': 'JlJIqlZFwrm6zbONmZ/iMQ==VPRfpbkewNAjTP2N'
      };

      ///RANDOM DOG
      if(randomPet == true) {
        String dogName = 'golden retriever';
        String dogApiUrl = 'https://api.api-ninjas.com/v1/dogs?name=$dogName';
        responseDog = await http.get(Uri.parse(dogApiUrl),headers: headers);

        // var request = http.Request('GET', Uri.parse(dogApiUrl));
        //
        // request.headers.addAll(headers);
        //
        // http.StreamedResponse responseDog = await request.send();

        if (responseDog.statusCode == 200) {
          final jsonDogData = json.decode(responseDog.body);
          // dogJson = jsonDogData as Map<String, dynamic>;
          dogJson = jsonDogData;

          pet = Pet(
            petID: randomID,
            name: dogJson['name'],
            photoURL: dogJson['image_link'],
            age: randomAge,
            species: "dog",
          );

          petRepository.addPetWithConverter(pet.petID, pet);

        } else {
          print('Request failed with status: ${responseDog.statusCode}');
        }
      }

      ///RANDOM CAT
      else {
        String catName = 'abyssinian';
        String catApiUrl = 'https://api.api-ninjas.com/v1/cat?name=$catName';
        responseCat = await http.get(Uri.parse(catApiUrl),
            headers: {'X-Api-Key': 'JlJIqlZFwrm6zbONmZ/iMQ==VPRfpbkewNAjTP2N'});

        if (responseCat.statusCode == 200) {
          final jsonCatData = json.decode(responseCat.body);
          CatJson = jsonCatData as Map<String, dynamic>;

          pet = Pet(
            petID: randomID,
            name: CatJson['name'],
            photoURL: CatJson['image_link'],
            age: randomAge,
            species: "cat",
          );

          petRepository.addPetWithConverter(pet.petID, pet);

        } else {
          print('Request failed with status: ${responseCat.statusCode}');
        }
      }

    } catch (err) {
      print('Error: $err');
    }
  }
}