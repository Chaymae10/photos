import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

 class Photo {
  static const baseUrl = "https://unreal-api.azurewebsites.net/photos";

  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  Photo.fromJson(Map<String, dynamic> jsonObj)
      : this(
    jsonObj["albumId"],
    jsonObj["id"],
    jsonObj["title"],
    jsonObj["url"],
    jsonObj["thumbnailUrl"],
  );
@override
String toString() => 'Photo {albumId: $albumId, id: $id ,title: $title, url: $url,thumbnailUrl:$thumbnailUrl}';

  static Future<List<dynamic>> fetchPhotos() async {
    final response =
    await http.get(Uri.parse('https://unreal-api.azurewebsites.net/photos'));
    if (response.statusCode == 200) {
      List<dynamic> photos = json.decode(response.body);
      photos.sort((a, b) => b['id'].compareTo(a['id']));
      return photos;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Photo> createPhoto({
    required String title,
    required String thumbnailUrl,
    int? albumId,
    String? url,
  }) async {
    final response = await http.post(Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'albumId': albumId,
        'url': url,
      }),
    );
    if (response.statusCode == 201) {
      return Photo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create photo');
    }
  }
 }




