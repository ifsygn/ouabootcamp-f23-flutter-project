import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShelterAddressWidget extends StatelessWidget {
  final String barinakAdresi =
      "Ankara Üniversitesi Veteriner Fakültesi Hayvan Hastanesi";
  final Uri mapsUrl = Uri.parse("https://www.google.com/maps/place/Ankara+%C3%9Cniversitesi+Veteriner+Fak%C3%BCltesi+Hayvan+Hastanesi/@39.9584876,32.8035677,13z/data=!4m10!1m2!2m1!1shayvan+hastanesi!3m6!1s0x14d34dd7a255b867:0x1fdaa407f88713dc!8m2!3d39.9584845!4d32.8636238!15sChBoYXl2YW4gaGFzdGFuZXNpWhIiEGhheXZhbiBoYXN0YW5lc2mSAQ9hbmltYWxfaG9zcGl0YWyaASRDaGREU1VoTk1HOW5TMFZKUTBGblNVTjRjRmszYlc5M1JSQULgAQA!16s%2Fg%2F11g71by0sw?entry=ttu");

  ShelterAddressWidget({super.key});

  void launchMapsUrl() async {
    if (!await launchUrl(mapsUrl)) {
      throw Exception('Could not launch $mapsUrl');
      //await launch(mapsUrl);
    } else {
      throw 'Yüklenemedi $mapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: launchMapsUrl,
      child: Row(
        children: [
          Image.asset(
            'assets/map.png',
            width: 85,
            height: 24,
          ),
          const Text(
            "Türkiye, Ankara",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}