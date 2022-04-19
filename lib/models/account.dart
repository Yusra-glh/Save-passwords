part 'account.g.dart';

class Account {
  String? id;
  String? email;
  String? password;
  String? title;
  double? strength;
  String? strengthValue;
  String? icon;

  Account(
      {
        this.email,
        this.id,
        this.password,
        this.title,
        this.strength,
        this.strengthValue,
        this.icon,
      });

  Map<String, dynamic> toJson() => {
    'email': email,
    'id': id,
    'password': password,
    'title': title,
    'strength': strength,
    'strengthValue': strengthValue,
    'icon': icon,
  };

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
