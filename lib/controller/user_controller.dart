import 'dart:js';

import 'package:flutter/material.dart';
import 'package:login_cadastro/database/user_database.dart';
import 'package:login_cadastro/model/user_model.dart';
import 'package:login_cadastro/ui/pages/homepage.dart';

class UserController {
  UserDatabase userDatabase = UserDatabase();

  void login(context, String nome, String password){
    var users = userDatabase.users;
    var result = users.where((user) => user.name == nome);
    if (result.isNotEmpty) {
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_)=> HomePage()),
        (route) => false);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Senha Inválida'),
        )
      );
    }
  }

  void cadastro(context, String nome, String password){
    var user = User(name: nome, password: password);
    var users = userDatabase.users;
    var add = users.add(user);
    var result = users.where((user) => user.name == nome);
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (_)=> HomePage()),
      (route) => false);
  }
}