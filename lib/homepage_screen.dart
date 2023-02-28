import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/constant/url_constant.dart';
import 'package:share_plus/share_plus.dart';

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

  launchurl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
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
        backgroundColor: Colors.redAccent,
        title: const Text(
          "NewsApp",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: FutureBuilder(
            future: fetchNews(),
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  ...snapshot.data["articles"].map(
                    (e) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () async {
                              launchurl(e["url"]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
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
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () async {
                              Share.share(
                                  "Do you want to share this news${e["url"]}");
                            },
                            icon: const Icon(Icons.share),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                return Center(child: Image.asset('assets/images/failed.jpg'));
                /*
                return Padding(
                  padding: const EdgeInsets.all(100),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent.shade400,
                    ),
                  ),
                ); 
                */
              } else {
                return Padding(
                  padding: const EdgeInsets.all(150),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.redAccent.shade400,
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
