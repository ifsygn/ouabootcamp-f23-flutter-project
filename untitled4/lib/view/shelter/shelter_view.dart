import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/view/shelter/shelter_viewmodel.dart';

import '../../core/data/entity/shelter.dart';

class ShelterScreen extends StatelessWidget {
  const ShelterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //Provider.of<ShelterViewModel>(context) kullanarak shelterViewModel değişkenini oluşturur.
    // Bu, ShelterViewModel sınıfının bir örneğini almak için Provider paketini kullanır.
    final shelterViewModel = Provider.of<ShelterViewModel>(context);

    //shelters değişkeni, shelterViewModel üzerinden shelters listesine erişimi sağlar.
    // Bu listenin içerisinde barınak verileri bulunur.
    final shelters = shelterViewModel.shelters;
    final sheltersLength = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Barınaklar'),
      ),
      body: FutureBuilder( //FutureBuilder widget'i kullanarak asenkron veri alımını yönetir.
        future: shelterViewModel.fetchShelters(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {

          //snapshot.connectionState ile veri durumunu kontrol eder.
          //Eğer bekleniyor (waiting) durumunda ise yükleniyor gösterecek
          //bir CircularProgressIndicator widget'ını döndürür.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );

            //snapshot.hasError ile hata kontrolü yapar.
            //Eğer hata varsa, bir hata mesajını içeren bir Text widget'ını döndürür.
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Veriler getirilirken bir hata oluştu.'),
            );
          } else {

            //Eğer herhangi bir hata veya bekleme durumu yoksa,
            // barınak listesini görüntülemek için ListView.builder widget'ını kullanır.

            return FutureBuilder<List<Shelter>>(
              future: shelters,
              builder: (BuildContext context, AsyncSnapshot<List<Shelter>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Veri yüklenirken gösterilecek widget
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Hata durumunda gösterilecek widget
                  return Text('Veriler getirilirken bir hata oluştu.');
                } else {
                  // Verilerin başarıyla yüklendiği durumda gösterilecek widget
                  final shelters = snapshot.data;
                  return ListView.builder(

                    //itemCount özelliği, listelenen barınak sayısını belirtir.
                    itemCount: sheltersLength,

                    //itemBuilder özelliği, her bir liste öğesi için bir widget oluşturur.
                    // shelters listesindeki her bir barınak için bir ListTile oluşturulur.
                    itemBuilder: (BuildContext context, int index) {
                      final shelter = shelters?[index];
                      return ListTile(

                        //title ve subtitle özellikleri,
                        // ListTile içindeki başlık ve alt başlık metinlerini belirtir.
                        // Barınak nesnesinden name ve location verilerini kullanır.
                        title: Text(shelter?.name ?? ''),
                        subtitle: Text(shelter?.location ?? ''),
                        // Diğer özellikleri göstermek için gerekli widget'ları ekleyin
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}