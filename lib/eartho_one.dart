import 'eartho_one_platform_interface.dart';

class EarthoOne {
  final String clientId;
  final String clientSecret;

  EarthoOne({required this.clientId, required this.clientSecret});

  /// Get the sdk version
  Future<String?> getPlatformVersion() {
    return EarthoOnePlatform.instance.getPlatformVersion();
  }

  /// Init the sdk
  Future<dynamic> init() async {
    return EarthoOnePlatform.instance.initEartho(clientId: clientId, clientSecret:clientSecret);
  }

  /// Starts the access flow
  ///
  /// accessId - which access the user should connect to
  /// take this value from creator.eartho.world
  Future<EarthoCredentials?> connectWithRedirect(String accessId) async {
    return EarthoOnePlatform.instance.connectWithRedirect(accessId);
  }

  /// After user connected, this function returns the id token of the user
  Future<String?> getIdToken() async {
    return EarthoOnePlatform.instance.getIdToken();
  }

  /// After user connected, this function returns user object
  Future<EarthoUser?> getUser() async {
    return EarthoOnePlatform.instance.getUser();
  }

  /// Disconnect this user from eartho and clear session
  Future<dynamic> disconnect() async {
    return EarthoOnePlatform.instance.disconnect();
  }
}

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