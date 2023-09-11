
class UserAvatarInformation {

final String? 
      message,
      data;

  UserAvatarInformation({
    this.message,
    this.data,
  });

  factory UserAvatarInformation.fromJson(Map<String, dynamic> json) =>
      UserAvatarInformation(
        message: json['message'],
        data: json['data'],

      );

  @override
  bool operator == (Object other) =>
    other is UserAvatarInformation &&
        this.message == other.message &&
        this.data == other.data;

@override
int get hashCode => Object.hash( message, data);

}
