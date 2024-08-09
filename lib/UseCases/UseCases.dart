
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:list_contacts/Models/User.dart';
import 'package:list_contacts/models/user.dart';
import '../NetWorkLayer/NetworkService.dart';
import '../Models/User.dart';
import '../Models/UserInformation.dart';

abstract class UserUseCase {
  Future<UserInfor> fetchUser(String userName);
  Future<List<UserInfor>> fetchUsers(int page, int limit);
}

class DBUseCase implements UserUseCase {
  final String baseUrl;

  DBUseCase({required this.baseUrl});

  @override
  Future<UserInfor> fetchUser(String userName) async {
    final url = Uri.parse('$baseUrl/users/$userName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserInfor.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<List<UserInfor>> fetchUsers(int page, int limit) async {
    final url = Uri.parse('$baseUrl/users?page=$page&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body) as List;
        return data.map((json) => UserInfor.fromJson(json)).toList();
      } catch (e) {
        // Handle the error when JSON mapping fails
        throw Exception('Failed to map JSON to UserInfor: ${e.toString()}');
      }
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

}