import 'package:http/http.dart' show Client;
import 'package:livescore/config/item_model.dart';
import 'package:livescore/materialui/cardview.dart';
import 'dart:convert';

class ApiProvider {
  Client client = Client();
  fetchPosts() async {
    final response = await client.get("https://jsonplaceholder.typicode.com/posts/1");
    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}