import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotels List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'List of The Avaliable Hotels'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'https://s3.amazonaws.com/koisys-interviews/hotels.json';

  late List<Api> _api;

  Future<List<Api>> _getHotel() async {
    try {
      List<Api> listHotels = [];
      final response =
          await http.get(Uri.parse(url)); // acessa a url com os dados
      if (response.statusCode == 200) {
        // checa se a conexão foi efetuada
        var decodeJson = jsonDecode(response
            .body); // decodifica os dados da api para que possam ser usados
        decodeJson.forEach((item) => listHotels.add(Api.fromJson(
            item))); //adiciona cada campo do json à lista de hotéis
        return listHotels; // retorna a lista já populada com os dados da api
      } else {
        print('Error');
        return [];
      }
    } catch (e) {
      print('Error');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _getHotel().then((map) {
      _api = map;
      print(_api.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 20);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Hotéis'),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: _api.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  elevation: 4,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                      width: 350,
                      height: 60,
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            _api[index].hotelName,
                            style: style,
                          ),
                          Text(
                            _api[index].price,
                            style: style,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )
                        ],
                      ))),
                );
              })),
    );
  }
}
