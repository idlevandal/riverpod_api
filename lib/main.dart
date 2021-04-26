import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api/photo_model.dart';
import 'package:riverpod_api/services/fetch_api.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    AsyncValue<List<PhotoModel>> photos = watch(photoStateProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(),
      body: photos.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) => Text(e.toString()),
        data: (val) {
          return ListView.builder(
            itemCount: val.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(val[index].thumbnailUrl),
                ),
                title: Text(val[index].title),
              );
            },
          );
        }
      ),
    );
  }
}
