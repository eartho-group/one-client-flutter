import 'package:flutter/material.dart';
import 'package:eartho_one/eartho_one.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  EarthoUser? _user;
  String? token;
  EarthoCredentials? _credentials;
  EarthoOne? earthoOne;
  @override
  void initState() {
    super.initState();

    earthoOne = EarthoOne(
        clientId: "qoWhmh4vAEZnE5Naig0b",
        clientSecret: "-----BEGIN PUBLIC KEY-----\n" +
            "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtHJ23XxMW2Yj2JaPZXRD\n" +
            "xkXCS+8xuOVc9qSsROCiutpumEk/QDqxUnGubig6dYSsY0ZqAekF+hYiub7PlBVa\n" +
            "uZRSydPG6jfC7fkvKtB6WccCeQqMP1YfZmsWFNbRluGoWEcHKJbYp7M+XVI8M+i0\n" +
            "/7pUnPOaOHqLbpKuX3WaBNb+YdiS0cUKgUJaphM7yhQXkfme3SqUYeXrqXHkYsnf\n" +
            "jC93o09mfeNtY7HrU22Aq6sJto4X7E07RPyc25OyzvBADOmg7zWGna34HL8GNUqL\n" +
            "c9VpGWo7uyxwomrwA84rIc979hn/TKK9AJMjhFVvU2e1mjAK+j4wB/HPrZrkG5W0\n" +
            "ywIDAQAB\n" +
            "-----END PUBLIC KEY-----\n");

    earthoOne?.init();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final credentials = await earthoOne?.connectWithRedirect("V1te8aEqOJNtPseu3VTe");
                    setState(() {
                      _credentials = credentials;
                    });
                  },
                  child: const Text("Login")),

              ElevatedButton(
                  onPressed: () async {
                    final user = await earthoOne?.getUser();
                    setState(() {
                      _user = user;
                    });
                  },
                  child: const Text("Get User")),
              ElevatedButton(
                  onPressed: () async {
                    final idToken = await earthoOne?.getIdToken();
                    setState(() {
                      token= idToken;
                    });
                  },
                  child: const Text("Get Id token")),
              Text(_user?.displayName ?? ''),
              Text(token ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
