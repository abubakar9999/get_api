import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_api/model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Model ourmodel;

  List<Model> mylist = [];
  GetdatainApi() async {
    var respons = await http.get(Uri.parse(
        "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json"));

    print(respons.body);

    if (respons.statusCode == 200) {
      var data = jsonDecode(respons.body);
      for (var mydata in data["exercises"]) {
        ourmodel = Model(
          id: mydata["id"],
          gif: mydata[" gif"],
          second: mydata["second"],
          thumbnail: mydata["thumbnail"],
        );
        setState(() {
          mylist.add(ourmodel);
        });
      }
    } else {
      CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    GetdatainApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Integration")),
      body: Column(
        children: [Center(child: Text(mylist[0].id.toString()))],
      ),
    );
  }
}
