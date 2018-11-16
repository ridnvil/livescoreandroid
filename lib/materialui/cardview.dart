import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Data> getData() async {
  final respon = await http.get('http://192.168.2.111/phprest/api/match/matchLive.php');

  print(respon.body);
}

class Data {
  final String status;
  final List message;
  final int rownum;
  final List data;

  Data({this.status,this.message,this.rownum,this.data});

  factory Data.fromJson(Map<String, dynamic> json){
    int i;
    return Data(
      status: json['status'],
      message: json['message'],
      rownum: json[i],
      data: json['contest']
    );
  }
}

class LiveMatch extends StatefulWidget {
  final Future<Data> data;

  LiveMatch({Key key, this.data}):super(key: key);
  @override
  _LiveMatchState createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}