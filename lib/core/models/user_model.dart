// ignore_for_file: always_specify_types

class UserModel {
  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.mochiAdvertiseId,
    required this.provider,
    required this.favouritList,
  });
  factory UserModel.fromJson(Map<String, dynamic> mapData, String id) {
    assert(mapData.isEmpty, 'Null User data recieved!');

    return UserModel(
      userId: id,
      email: mapData['email'],
      name: mapData['name'],
      photoUrl: mapData['photoUrl'],
      mochiAdvertiseId: mapData['mochiAdvertiseId'],
      provider: mapData['provider'],
      favouritList: mapData['favouriteList'],
    );
  }
  late String userId;
  late String email;
  late String name;
  late String photoUrl;
  late String provider;
  late String mochiAdvertiseId;
  late List<String> favouritList = [];
  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'userId': userModel.userId,
      'email': userModel.email,
      'name': userModel.name,
      'photoUrl': userModel.photoUrl,
      'mochiAdvertiseId': userModel.mochiAdvertiseId,
      'provider': userModel.provider,
      'favouriteList': userModel.favouritList
    };
  }
}
