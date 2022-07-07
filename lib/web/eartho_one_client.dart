// ignore_for_file: non_constant_identifier_names

@JS()
library eartho_one;

import 'dart:html';

import 'package:js/js.dart';

@JS('EarthoOne')
class EarthoOneWeb {
  external EarthoOneWeb(EarthoOneOptions options);
  external getIdToken();
  external Future<WebEarthoUser> getUser();
  external handleRedirectCallback();
  external isConnected();
  external connectWithPopup(LoginWithPopupOptions options);
  external connectWithRedirect(RedirectLoginOptions options);
  external disconnect();
}

@anonymous
@JS()
abstract class WebEarthoUser {
  external String uid;
  external String displayName;
  external factory WebEarthoUser(
      {String uid,
        String displayName});
}

@JS()
@anonymous
class EarthoOneOptions {
  external factory EarthoOneOptions(
      {String client_id,
      String redirect});
  external String get client_id;
  external String get redirect;
}

@JS()
@anonymous
class RedirectLoginOptions {
  external factory RedirectLoginOptions({String redirect_uri});
  external String get redirect_uri;
}


@JS()
@anonymous
class LoginWithPopupOptions {
  external factory LoginWithPopupOptions({String access_id});
  external String get access_id;
}
