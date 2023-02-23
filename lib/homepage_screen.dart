import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newsapp/constant/url_constant.dart';
import 'package:newsapp/widget/news_card.dart';

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
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder(
              future: fetchNews(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    ...snapshot.data["articles"].map((e) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Image.network(e["urlToImage"] ?? No_image),
                                const Padding(padding: EdgeInsets.all(8)),
                                Column(
                                  children: [
                                    Text(
                                      e["title"] ?? "...",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e["description"] ?? "..",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                  ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              }),
            ),
          ),
        ));
  }
}
