import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class EarthoCredentials {
  final String? tokenType;
  final String? refreshToken;
  final String? idToken;
  final String? scope;
  final String? recoveryCode;

  EarthoCredentials(this.tokenType, this.refreshToken, this.idToken, this.scope,
      this.recoveryCode);

  EarthoCredentials.fromJSON(Map<String, dynamic> json)
      : tokenType = json['tokenType'] ?? json['token_type'],
        refreshToken = json['refreshToken'] ?? json['refresh_token'],
        idToken = json['idToken'] ?? json['id_token'],
        scope = json['scope'],
        recoveryCode = json['recoveryCode'] ?? json['recovery_code'];
}

class EarthoUser {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final String? firstName;
  final String? lastName;
  final String? phone;

  EarthoUser(this.uid, this.displayName, this.email, this.photoURL,
      this.firstName, this.lastName, this.phone);

  EarthoUser.fromJSON(Map<String, dynamic> json)
      : uid = json['uid'] ?? json['id'],
        displayName = json['displayName'] ?? json['displayName'],
        email = json['email'] ?? json['email'],
        photoURL = json['photoURL'] ?? json['photoURL'],
        firstName = json['firstName'] ?? json['firstName'],
        lastName = json['lastName'] ?? json['lastName'],
        phone = json['phone'] ?? json['phone'];
}

class EarthoOne {
  static const MethodChannel _channel = MethodChannel('eartho_one');

  final String clientId;
  final String clientSecret;

  EarthoOne({required this.clientId, required this.clientSecret});

  Future<dynamic> init() async {
     final a = await _channel.invokeMethod(
        'init', {"clientId": clientId, "clientSecret": clientSecret});
  }

  Future<EarthoCredentials> connectWithRedirect(String accessId) async {
    final rawJson = await _channel
        .invokeMethod('connectWithRedirect', {"accessId": accessId});
    final decodedJson = jsonDecode(rawJson);
    return EarthoCredentials.fromJSON(decodedJson);
  }

  Future<String> getIdToken() async {
    final rawJson = await _channel.invokeMethod('getIdToken');
    // final decodedJson = jsonDecode(rawJson);
    return rawJson;
  }

  Future<EarthoUser?> getUser() async {
    final rawJson = await _channel.invokeMethod('getUser');
    if (rawJson == null) return null;
    final decodedJson = jsonDecode(rawJson);
    return EarthoUser.fromJSON(decodedJson);
  }

  Future<dynamic> disconnect() async {
    return await _channel.invokeListMethod('disconnect');
  }
}
