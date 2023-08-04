import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact/user.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDataProvider(),
      child: MaterialApp(
        title: 'Flutter JSON Provider',
        home: HomeScreen(),
      ),
    );
  }
}

class UserDataProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  void fetchUserData(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    _user = User.fromJson(data);
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Data')),
      body: Center(
        child: Consumer<UserDataProvider>(
          builder: (context, userData, _) {
            if (userData.user == null) {
              return Text('User data not available.');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${userData.user!.name}'),
                  Text('Age: ${userData.user!.age.toString()}'),
                  Text('Email: ${userData.user!.email}'),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 여기서는 간단한 문자열 형태의 JSON 데이터를 가정합니다.
          // 실제 앱에서는 네트워크를 통해 JSON 데이터를 가져오는 것이 일반적입니다.
          String jsonData = '{"name": "이성진", "age": 40, "email": "icetea0111@naver.com"}';
          Provider.of<UserDataProvider>(context, listen: false).fetchUserData(jsonData);
        },
        child: Icon(Icons.refresh, size: 50,),
      ),
    );
  }
}


