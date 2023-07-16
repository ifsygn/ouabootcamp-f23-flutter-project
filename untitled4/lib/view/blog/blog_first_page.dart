import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/common/widget/appbarwidget.dart';
import 'package:untitled4/common/widget/nav_drawer.dart';
import 'package:untitled4/core/data/entity/blog.dart';
import 'package:untitled4/core/data/repository/blog_repository.dart';
import 'package:untitled4/core/service/firebase_auth_service.dart';
import 'package:untitled4/view/blog/blog_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BlogAnaSayfa(),
    );
  }
}

class BlogAnaSayfa extends StatelessWidget {
  const BlogAnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const appBarWidget(
        title: 'Blog',
      ),
      drawer: NavDrawer(),
      body: arkaplan(),
    );
  }
}
bool userCheck = false;
class arkaplan extends StatelessWidget {
  final User? user = Auth().currentUser;
  arkaplan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyModelService myModelService = MyModelService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GetAllDataList(myModelService: myModelService),
        ),
        const SizedBox(
          height: 10,
        ),
        const TextPopuler(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GetPopularDataList(myModelService: myModelService),
        ),
      ],
    );
  }
}

class TextSonEklenen extends StatelessWidget {
  const TextSonEklenen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 256,
      child: Text(
        'Son Eklenen Bloglar',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 22.0,
        ),
      ),
    );
  }
}

class GetPopularDataList extends StatefulWidget {
  final MyModelService myModelService;

  const GetPopularDataList({
    Key? key,
    required this.myModelService,
  }) : super(key: key);

  @override
  _GetPopularDataListState createState() => _GetPopularDataListState();
}

class _GetPopularDataListState extends State<GetPopularDataList> {
  late Future<List<MyBlogModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.myModelService.getPopularMyModels();
  }

  Widget buildContainer(MyBlogModel myModel) {
    return FutureBuilder<String?>(
      future: widget.myModelService.downloadImage(myModel.imageName),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Hata: Resim yüklenirken bir hata oluştu');
        } else {
          final imageUrl = snapshot.data;
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(myModel: myModel),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.only(left: 20, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            imageUrl ?? '',
                            height: 160,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              myModel.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MyBlogModel>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<MyBlogModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final myModels = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myModels.length,
              itemBuilder: (BuildContext context, int index) {
                final myModel = myModels[index];
                return buildContainer(myModel);
              },
            );
          }
        },
      ),
    );
  }
}

class GetAllDataList extends StatefulWidget {
  final MyModelService myModelService;

  const GetAllDataList({
    Key? key,
    required this.myModelService,
  }) : super(key: key);

  @override
  _GetAllDataListState createState() => _GetAllDataListState();
}

class _GetAllDataListState extends State<GetAllDataList> {
  late Future<List<MyBlogModel>> _future;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _future = widget.myModelService.getMyModels();
  }

  Widget buildContainer(MyBlogModel myModel) {
    return FutureBuilder<String?>(
      future: widget.myModelService.downloadImage(myModel.imageName),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Hata: Resim yüklenirken bir hata oluştu');
        } else {
          final imageUrl = snapshot.data;
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(myModel: myModel),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        imageUrl ?? '',
                        height: 160,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        myModel.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  List<MyBlogModel> filterBySearchText(List<MyBlogModel> myModels, String searchText) {
    if (searchText.isEmpty) {
      return myModels;
    } else {
      return myModels
          .where((myModel) => myModel.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(width: 0.8),
              ),
              hintText: 'Blog Ara',
              prefixIcon: const Icon(Icons.search, size: 30),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    searchText = '';
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<MyBlogModel>>(
            future: _future,
            builder: (BuildContext context, AsyncSnapshot<List<MyBlogModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              } else {
                final myModels = snapshot.data!;
                final filteredMyModels = filterBySearchText(myModels, searchText);
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredMyModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    final myModel = filteredMyModels[index];
                    return buildContainer(myModel);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class TextPopuler extends StatelessWidget {
  const TextPopuler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 215,
      child: Text(
        'Popüler Bloglar',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 22.0,
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final MyModelService myModelService;
  final Function(String) onSearch;

  const SearchBox({
    Key? key,
    required this.myModelService,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.8),
        ),
        hintText: 'Blog Ara',
        prefixIcon: const Icon(Icons.search, size: 30),
      ),
    );
  }
}
