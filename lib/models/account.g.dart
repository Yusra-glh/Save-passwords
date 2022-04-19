part of 'account.dart';

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'],
    password:json['password'],
    email: json['email'],
    title: json['title'],
    strength: json['strength'],
    strengthValue: json['strengthValue'],
    icon: json['icon'],
  );

}
