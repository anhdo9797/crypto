class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  num? balance;

  UserModel(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.avatar,
      this.balance});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['balance'] = balance;
    return data;
  }
}
