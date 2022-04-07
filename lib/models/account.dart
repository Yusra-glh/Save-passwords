part 'account.g.dart';

class Account {
  String? id;
  String? email;
  String? password;

  Account(
      {
        this.email,
        this.id,
        this.password,
      });

  Map<String, dynamic> toJson() => {
    'email': email,
    'id': id,
    'password': password,
  };

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
