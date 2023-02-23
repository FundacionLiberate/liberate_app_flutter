import 'package:json_annotation/json_annotation.dart';
part 'liberate_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LiberateUser{

  late String email;
  late String name;
  late String uid;
  late DateTime creationDate;


  LiberateUser();
  LiberateUser.newUser(this.email, this.name, this.uid, this.creationDate);

  factory LiberateUser.fromJson(Map<String, dynamic> json) => _$LiberateUserFromJson(json);
  Map<String, dynamic> toJson() => _$LiberateUserToJson(this);

}