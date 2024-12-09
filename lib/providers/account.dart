import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';
import 'package:netflix_clone/apis/client.dart';

import '../data/store.dart';

class AccountProvider extends ChangeNotifier {
  User? _current;
  User? get current => _current;

  Session? _session;
  Session? get session => _session;

  Future<Session?> get _cachedSession async {
    final cached = await Store.get("session");

    if (cached == null) {
      return null;
    }
    return Session.fromMap(json.decode(cached));
  }

  Future<bool> isValid() async {
    await Future.delayed(const Duration(seconds: 3));
    if (session == null) {
      final cahced = await _cachedSession;

      if (cahced == null) {
        return false;
      }
      _session = cahced;
    }

    return session != null;
  }

  Future<void> register(String email, String password, String name) async {
    try {
      final result = await ApiClient.account.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      );
      _current = result;
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to register: $e");
    }
  }
  
  Future<void> login(String email, String password) async {
    try {
      final result = await ApiClient.account.createEmailPasswordSession(email: email, password: password);
      _session = result;
      Store.set("session", json.encode(result.toMap()));
      notifyListeners();
    } catch (e) {
      _session = null;
      throw Exception("Failed to login: $e");
    }
  }
}
