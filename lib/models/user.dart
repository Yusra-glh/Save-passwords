part 'user.g.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? image;
  String? password;

  UserModel(
      {
        this.email,
        this.id,
        this.name,
        this.image,
        this.password
       });

  Map<String, dynamic> toJson() => {
    'email': email,
    'id': id,
    'name': name,
    'image': image,
    'password': password,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
