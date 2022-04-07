part of 'account.dart';

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'],
    password:json['password'],
    email: json['email'],
  );

}
