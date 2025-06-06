import 'dart:convert';

import 'package:schoolcycle_mobile/business/models/announcement/announcement.dart';
import 'package:schoolcycle_mobile/business/models/category/category.dart';
import 'package:schoolcycle_mobile/business/models/user/authentification.dart';
import 'package:schoolcycle_mobile/business/models/user/user.dart';
import 'package:schoolcycle_mobile/business/service/schoolCycleNetworkService.dart';
import 'package:http/http.dart' as http;

class Schoolcyclenetworkimpl implements SchoolcycleNetworkService {
  var apiBaseUrl = "http://127.0.0.1";

  @override
  Future<Announcement> getAnnouncement() {
    // TODO: implement getAnnouncement
    throw UnimplementedError();
  }

  @override
  Future<List<Announcement>> getAnnouncements() async {
    var url = Uri.parse("${apiBaseUrl}/announcements");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // Assuming the response body is a JSON array of announcements
      //var listData = jsonDecode(response as String);
      var listData = jsonDecode(response.body);
      var listAnnouncements = listData['data'];
      listAnnouncements =
          listAnnouncements
              .map<Announcement>((e) => Announcement.fromJson(e))
              .toList();
      return listAnnouncements;
    } else {
      throw Exception('Failed to load announcements');
    }
  }

  @override
  Future<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategory() {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<User?> authenfication(Authentification data) async {
    var url = Uri.parse("${apiBaseUrl}");
    var body = jsonEncode({'email': data.email, 'password': data.password});
    var response = await http.post(
      url,
      headers: {
        'Content-type': "application/json",
        'Accept': "application/json",
      },
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      print("Erreur : une erreur est survenue");
    }
  }
}
