part 'user.g.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? image;

  UserModel(
      {
        this.email,
        this.id,
        this.name,
        this.image,
       });

  Map<String, dynamic> toJson() => {
    'email': email,
    'id': id,
    'name': name,
    'image': image,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
