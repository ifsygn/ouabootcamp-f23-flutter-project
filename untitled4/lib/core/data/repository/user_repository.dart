import 'package:geolocator/geolocator.dart';

class UserRepository {

  ///Konum bilgilerini almak için aşağıdaki gibi bir fonksiyon oluşturabilirsiniz:
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servislerinin etkin olup olmadığını kontrol edin
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum servisleri etkin değilse kullanıcıyı yönlendirin veya hata mesajı gösterin
      throw Exception('Konum servisleri etkin değil');
    }

    // Konum izni kontrolü yapın
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // İzin reddedilmişse, izin isteyin
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // İzin reddedilirse kullanıcıyı yönlendirin veya hata mesajı gösterin
        throw Exception('Konum izni reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // İzin kalıcı olarak reddedildiyse kullanıcıyı yönlendirin veya hata mesajı gösterin
      throw Exception('Konum izni kalıcı olarak reddedildi');
    }

    // Konum bilgilerini alın
    return await Geolocator.getCurrentPosition();
  }

  
}