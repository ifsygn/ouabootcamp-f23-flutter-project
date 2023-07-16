import 'package:flutter/material.dart';
import '../../core/service/firebase_auth_service.dart';
import '../../view/shelter/shelter_route_page.dart';
import 'appbarwidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState()
  {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const appBarWidget(
          title: 'Ana Sayfa',),
          body: const Center(
            child: Center(child: Text("Ana Sayfa"))
        ),
        drawer: NavDrawer()
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child:NavDrawerWidget() ,
    );
  }
}

class NavDrawerWidget extends StatelessWidget {

  Future<void> signOut() async {
    await Auth().signOut();
  }

  const NavDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
         DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,

          ),

          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: Icon(Icons.account_circle, color: Colors.grey,size: 40,),
                  flex: 2,

                ),

                Expanded(
                  flex: 6,
                  child: Text(
                    "F23 Team",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,

                    ),
                  ),
                ),
              ],

            ),
          ),
        ),

        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text("Ana Sayfa",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),


            leading: IconButton(
              icon: const Icon(Icons.home, color: Colors.grey,size: 20,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage()
                )
              );
            },
          ),
        ),

        const Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text("Barınaklar",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),
            leading: IconButton(
              icon: const Icon(Icons.night_shelter,color: Colors.grey,size: 20,),
              onPressed: () {
              },
            ),

            onTap: ()
            {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ShelterRoutePage()));
            },
          ),),
        const Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text("Hayvanlar",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),
            leading: IconButton(
              icon: const Icon(Icons.pets_sharp ,color: Colors.grey,size: 20,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Hayvanlar()));
            },
          ),),
        const Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 40,
          child: ListTile(

            title: const Text("Hayvanlarım",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),
            leading: IconButton(
              icon: const Icon(Icons.pets,color: Colors.grey,size: 20,),
              onPressed: () {
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Hayvanlarim()),
              );
            },
          ),),
        const Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text("Kaydedilenler",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),
            leading: IconButton(
              icon: const Icon(Icons.folder, color: Colors.grey,size: 20,),
              onPressed: () {
              },
            ),
            onTap: ()
            {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Kaydedilenler()));
            },
          ),),
        const Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 40,
          child: ListTile(
            title: const Text("Dark Mode",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,

              ),),
            leading: IconButton(
              icon: const Icon(Icons.dark_mode,color: Colors.grey,size: 20,),
              onPressed: () {
              },
            ),

          ),),
        const Divider(
            color: Colors.grey
        ),
        const Divider(
          height:80.0,

        ),
        SizedBox(

          height: 40,
          child: ListTile(
            title: const Text("Log Out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),),
            leading: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {

              },
            ),
            onTap: ()
            {
              signOut();
            },
          ),)
      ],
    );
  }
}

class Hayvanlar extends StatelessWidget {
  static const String routeName = '/Hayvanlar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const appBarWidget(
          title: 'Hayvanlar',
        ),
        drawer: NavDrawer(),
        body: const Center(child: Text("This is Hayvanlar page")));
  }
}

class Hayvanlarim extends StatelessWidget {
  static const String routeName = '/Hayvanlarım';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const appBarWidget(
        title: 'Hayvanlarım',),
        drawer: NavDrawer(),
        body: const Center(child: Text("This is Hayvanlarım page")));
  }
}

class Kaydedilenler extends StatelessWidget {
  static const String routeName = '/Kaydedilenler';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const appBarWidget(
          title: 'Kaydedilenler',
        ),
        drawer: NavDrawer(),
        body: const Center(child: Text("This is Kaydedilenler page")));
  }
}

