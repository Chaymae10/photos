import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/photo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../views/formAddPhoto.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: Future.delayed(const Duration(seconds: 1), () => Photo.fetchPhotos()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final post = snapshot.data?[index];
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      post['thumbnailUrl'].toString(), //ajouter to string car cela genere des erreurs et jsp pk
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(post['id'].toString()),
                      const SizedBox(width: 10),
                      Text(post['title'].toString()),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return const Center(
              child: SpinKitChasingDots(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPhotoForm()),
          );
        },
        tooltip: 'Add Photo',
        child: Icon(Icons.add),
      ),
    );
  }
}


