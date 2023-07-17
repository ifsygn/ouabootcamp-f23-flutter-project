import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/common/helper/route/route_constant.dart';
import '../../../core/data/entity/users.dart';
import '../../../core/data/repository/user_repository.dart';
import '../../../core/service/firebase_auth_service.dart';
import '../../../view/blog/home_page.dart';
import '../../../view/shelter/shelter_route_page.dart';

UserRepository userRepository = UserRepository();
User? currentUser = Auth().currentUser;

class MyNavigationDrawer extends StatefulWidget {

  const MyNavigationDrawer({super.key});

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {

  late String userName = "";
  late String userProfilePhotoURL = "";
  late String userEmail = "";
  late bool isDarkMode = false;
  // late ValueChanged<bool> onDarkModeToggle;

  @override
  void initState() {
    super.initState();
    // Veri tabanından currentAccountPicture, accountName ve accountEmail bilgilerini çekme işlemleri burada yapılabilir.
    // Örnek bir veri tabanı sorgusu:
    currentUser = Auth().currentUser;
    fetchUserDataFromDatabase();
  }

  void fetchUserDataFromDatabase() async {
    final String? userID = currentUser?.uid;
    Users? user = await userRepository.getUserSnapshotByID(userID!);

    if (user != null) {
      setState(() {
        userName = user.name!;
        userEmail = user.email;
        userProfilePhotoURL = user.profilPhotoURL!;
      });
    } else {
      // Handle the case when the user is not found or the query returns null.
      // For example, you can set default values or show an error message.
      setState(() {
        userName = "User Not Found";
        userEmail = "user@example.com";
        userProfilePhotoURL =
        "https://example.com/default-profile-image.jpg";
      });
    }
  }


  void toggleDarkMode(bool isDarkMode) {
    setState(() {
      this.isDarkMode = isDarkMode;
      // Add your dark mode logic here, e.g., change theme, save preference, etc.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Arka planı beyaz yapar
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: userProfilePhotoURL.isEmpty
                            ? const AssetImage('assets/profil-placeholder.png') // Replace with your placeholder image
                            : Image.network(userProfilePhotoURL).image,
                      ),
                      accountEmail: Text(
                        userEmail,
                        style:
                        const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      accountName: null,
                    ),
                    ListTile(
                      title: const Text(
                        "Ana Sayfa",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.home, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>const HomePage(),
                        ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Barınaklar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.night_shelter,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>const ShelterRoutePage(),
                        ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Hayvanlar",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.pets_sharp,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const FavoritedPets(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Hayvanlarım",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.pets, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const MyPet(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Veteriner",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.local_hospital,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Veteriner(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Bakımevleri",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.house, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Bakimevleri(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Mağaza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading:
                      const Icon(Icons.store, color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Magaza(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Kaydedilenler",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.folder,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Kaydedilenler(),
                          ),
                        );
                      },
                    ),
                    SwitchListTile(
                      title: const Text(
                        "Dark Mode",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      secondary: const Icon(Icons.dark_mode,
                          color: Colors.grey, size: 20),
                      value: isDarkMode,
                      onChanged: toggleDarkMode,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.pushNamed(context, RouteConstant.loginScreenRoute);

                Auth().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }


}

class Barinaklar extends StatelessWidget {
  const Barinaklar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Barınaklar"),
      ),
      body: const Center(child: Text("This is Barınaklar page")),
    );
  }
}

class FavoritedPets extends StatelessWidget {
  const FavoritedPets({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hayvanlar"),
      ),
      body: const Center(child: Text("This is Hayvanlar page")),
    );
  }
}

class MyPet extends StatelessWidget {
  const MyPet({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hayvanlarım"),
      ),
      body: const Center(child: Text("This is Hayvanlarım page")),
    );
  }
}

class Veteriner extends StatelessWidget {
  const Veteriner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Veteriner"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/dog.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyNavigationDrawer(),
    );
  }
}

class Bakimevleri extends StatelessWidget {
  const Bakimevleri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bakimevleri"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/pet_loading.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Magaza extends StatelessWidget {
  const Magaza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Magaza"),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "images/cute_dog.gif",
              width: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar genişlik
              height: screenSize.width *
                  0.8, // Ekran genişliğinin %80'i kadar yükseklik
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOut,
                );
              },
              filterQuality: FilterQuality.high,
              cacheWidth: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak genişlik değeri
              cacheHeight: (screenSize.width * 0.8)
                  .toInt(), // Önbelleğe alınacak yükseklik değeri
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: screenSize.height * 0.1),
              child: Text(
                "Yakında Görüşürüz",
                style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//https://miro.medium.com/v2/resize:fit:640/1*zzTEyTwyy7jXibtqVWg84Q.gif

class Kaydedilenler extends StatelessWidget {
  const Kaydedilenler({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kaydedilenler"),
      ),
      body: const Center(child: Text("This is Kaydedilenler page")),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logout"),
      ),
      body: const Center(child: Text("This is Logout page")),
    );
  }
}
