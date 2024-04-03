class User {
  String name;
  String password;

  User({required this.name, required this.password});

  @override
  String toString() {
    return "nome: $name";
  }
}