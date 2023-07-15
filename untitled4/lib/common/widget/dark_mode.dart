import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeData
          .light()), // Varsayılan tema ayarını burada ayarlayabilirsiniz
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter',
      theme: themeNotifier.getTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentAccountPicture = "";
  String accountEmail = "";
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    fetchUserDataFromDatabase();
  }

  void fetchUserDataFromDatabase() {
    setState(() {
      currentAccountPicture =
      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250";
      accountEmail = "aleyna.toprak5461@gmail.com";
    });
  }

  void toggleDarkMode(bool value, ThemeNotifier themeNotifier) {
    setState(() {
      isDarkMode = value;
      ThemeData theme = isDarkMode ? ThemeData.dark() : ThemeData.light();
      theme = theme.copyWith(primaryColor: Colors.purple);
      themeNotifier.setTheme(theme);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: const SingleChildScrollView(
        child: Center(child: Text("Ana Sayfa")),
      ),
      drawer: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, _) => NavDrawer(
          currentAccountPicture: currentAccountPicture,
          accountEmail: accountEmail,
          isDarkMode: themeNotifier.getTheme().brightness == Brightness.dark,
          onDarkModeToggle: (value) => toggleDarkMode(value, themeNotifier),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final String currentAccountPicture;
  final String accountEmail;
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeToggle;

  const NavDrawer({
    required this.currentAccountPicture,
    required this.accountEmail,
    required this.isDarkMode,
    required this.onDarkModeToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(currentAccountPicture),
                      ),
                      accountEmail: Text(
                        accountEmail,
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const MyHomePage(),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                            const Barinaklar(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text(
                        "Blog",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      leading: const Icon(Icons.menu_book,
                          color: Colors.grey, size: 20),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Blog(),
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
                            const Hayvanlar(),
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
                            const Hayvanlarim(),
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
                      onChanged: onDarkModeToggle,
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Logout(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Barinaklar extends StatelessWidget {
  const Barinaklar({Key? key}) : super(key: key);

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

class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: const Center(child: Text("This is Blog page")),
    );
  }
}

class Hayvanlar extends StatelessWidget {
  const Hayvanlar({Key? key}) : super(key: key);

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

class Hayvanlarim extends StatelessWidget {
  const Hayvanlarim({Key? key}) : super(key: key);

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
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
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
              cacheWidth: (screenSize.width * 0.8).toInt(),
              cacheHeight: (screenSize.width * 0.8).toInt(),
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
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
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
              cacheWidth: (screenSize.width * 0.8).toInt(),
              cacheHeight: (screenSize.width * 0.8).toInt(),
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
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
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
              cacheWidth: (screenSize.width * 0.8).toInt(),
              cacheHeight: (screenSize.width * 0.8).toInt(),
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

class Kaydedilenler extends StatelessWidget {
  const Kaydedilenler({Key? key}) : super(key: key);

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
  const Logout({Key? key}) : super(key: key);

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

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
