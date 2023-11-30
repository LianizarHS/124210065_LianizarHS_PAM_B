import 'package:flutter/material.dart';

import 'package:news/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

// ignore: camel_case_types
class _loginpageState extends State<loginpage> {
  final _uname = TextEditingController();
  final _pass = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;

  void initState() {
    super.initState();
    cek_if_already_login();
  }

  void cek_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login") ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }
  }

  @override
  void dispose() {
    _uname.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: _uname,
                decoration: const InputDecoration(label: Text("Username")),
              ),
              TextField(
                controller: _pass,
                decoration: const InputDecoration(label: Text("Password")),
              ),
              OutlinedButton(
                  onPressed: () {
                    String uname = _uname.text;
                    String pass = _pass.text;

                    if (uname == "asd" && pass == "123") {
                      logindata.setBool("login", false);
                      logindata.setString('username', uname);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    }
                  },
                  child: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
