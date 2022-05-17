part 'account.g.dart';

class Account {
  String? id;
  String? email;
  String? password;
  String? title;
  double? strength;
  String? strengthValue;
  String? icon;

  Account({
    this.email,
    this.id,
    this.password,
    this.title,
    this.strength,
    this.strengthValue,
    this.icon,
  });

  Map<String, dynamic> toJson() => {
        if (email != null) 'email': email,
        if (id != null) 'id': id,
        if (password != null) 'password': password,
        if (title != null) 'title': title,
        if (strength != null) 'strength': strength,
        if (strengthValue != null) 'strengthValue': strengthValue,
        if (icon != null) 'icon': icon,
      };

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
