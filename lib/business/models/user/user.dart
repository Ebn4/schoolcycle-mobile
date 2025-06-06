class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.email, required this.name});

  factory User.fromJson(json) =>
      User(id: json['id'], name: json['name'], email: json['email']);

  Map toJson() => {'id': id, 'email': email, 'name': name};
}
