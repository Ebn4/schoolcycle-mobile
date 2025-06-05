class Authentification {
  final String email;
  final String password;

  Authentification({required this.email, required this.password});

  factory Authentification.fromJson(json) =>
      Authentification(email: json['email'], password: json['password']);

  Map toJson() => {'email': email, 'password': password};
}
