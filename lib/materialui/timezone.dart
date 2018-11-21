import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Timezone extends StatefulWidget {
  final List loc;
  const Timezone({Key key, this.loc}):super(key: key);
  @override
  _TimezoneState createState() => _TimezoneState();
}

class _TimezoneState extends State<Timezone> {
  var url = "http://192.168.2.51/azsolusindo/public/api/timezoneName";
  Map data;
  List datalist;

  Future<List> getTimezone() async {
    http.Response response = await http.get(url);
    data = json.decode(response.body);
    datalist = data["data"];
    return datalist;
  }

  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    getTimezone();
    return DropdownMenuItem(
      child: new Text('data'),
      value: datalist.toList(),
    );
  }
}