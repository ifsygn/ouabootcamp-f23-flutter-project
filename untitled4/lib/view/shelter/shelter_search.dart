import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShelterSearchPage extends StatefulWidget {
  const ShelterSearchPage({super.key});

  @override
  _ShelterSearchPageState createState() => _ShelterSearchPageState();
}

class _ShelterSearchPageState extends State<ShelterSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _shelters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barınak Arama'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Arama',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _performSearch(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _shelters.length,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text('Title'),// Text(_shelters[index].data()!['name'] as String),
                  subtitle: Text('SubTitle'), // Text(_shelters[index].data()!['city'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch(String query) async {
    final sheltersSnapshot = await FirebaseFirestore.instance
        .collection('shelters')
        .where('name', isGreaterThanOrEqualTo: query)
        .get();

    setState(() {
      _shelters = sheltersSnapshot.docs;
    });
  }
}