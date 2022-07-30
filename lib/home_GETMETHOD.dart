import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'photo_model.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<PhotosModel>> getAllData() async {
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data = await http.get(Uri.parse(api));

    var jsondata = await json.decode(data.body);
    List<PhotosModel> listOf = [];
    for (var i in jsondata) {
      PhotosModel data =
      await    PhotosModel(i["id "], i['title'], i['url'], i['thumbnailUrl']);
      listOf.add(data);
    }
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: FutureBuilder(
          future: getAllData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("data"),
              );
            } else {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                print(
                  snapshot.data.length,
                );

                return Column(
                  children: [
                    Text(snapshot.data[index].url),
                    Image.network(snapshot.data[index].url)
                  ],
                );
              },
            );
          }
          },
          ),
    );
  }
}
