class UserModel {
  String? uid;
  String? name;
  String? avatar;
  bool? online;

  UserModel({
    this.uid,
    this.name,
    this.avatar,
    this.online,
});

  UserModel.fromJson(Map<String,dynamic> json){
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
    online = json['online'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['avatar'] = avatar;
    data['online'] = online;
    return data;
  }
}