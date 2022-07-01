import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

/// EarthoUser
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

/// EarthoUser
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

/// Official Eartho SDK
/// https://creator.eartho.wolrd
class EarthoOne {
  static const MethodChannel _channel = MethodChannel('eartho_one');

  final String clientId;
  final String clientSecret;

  EarthoOne({required this.clientId, required this.clientSecret});

  /// Init the sdk
  Future<dynamic> init() async {
     final a = await _channel.invokeMethod(
        'init', {"clientId": clientId, "clientSecret": clientSecret});
  }

  /// Starts the access flow
  ///
  /// accessId - which access the user should connect to
  /// take this value from creator.eartho.world
  Future<EarthoCredentials> connectWithRedirect(String accessId) async {
    final rawJson = await _channel
        .invokeMethod('connectWithRedirect', {"accessId": accessId});
    final decodedJson = jsonDecode(rawJson);
    return EarthoCredentials.fromJSON(decodedJson);
  }

  /// After user connected, this function returns the id token of the user
  Future<String> getIdToken() async {
    final rawJson = await _channel.invokeMethod('getIdToken');
    // final decodedJson = jsonDecode(rawJson);
    return rawJson;
  }

  /// After user connected, this function returns user object
  Future<EarthoUser?> getUser() async {
    final rawJson = await _channel.invokeMethod('getUser');
    if (rawJson == null) return null;
    final decodedJson = jsonDecode(rawJson);
    return EarthoUser.fromJSON(decodedJson);
  }

  /// Disconnect this user from eartho and clear session
  Future<dynamic> disconnect() async {
    return await _channel.invokeListMethod('disconnect');
  }
}
