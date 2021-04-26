import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:riverpod_api/photo_model.dart';

final photoStateProvider = FutureProvider<List<PhotoModel>>((ref) {
  return fetchPhotos();
});

Future<List<PhotoModel>> fetchPhotos() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/photos');

  if (response.statusCode == 200) {
    var lst = json.decode(response.body) as List<dynamic>;
    List<PhotoModel> pics = lst.map((el) => PhotoModel.fromJson(el)).toList();
    return pics;
  } else {
    print('ERROR....');
    throw Exception('Could not get the pics...');
  }
}