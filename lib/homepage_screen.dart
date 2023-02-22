import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/constant/url_constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  fetchNews() async {
    var url = Uri.parse(NEWS_API_url);
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          )
        ],
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                exit(0);
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          "NewsApp",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(snapshot.data.toString()),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
