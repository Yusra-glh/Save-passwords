part of 'user.dart';

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'],
    image:json['image'],
    name: json['name'],
    email: json['email'],
    );

}
