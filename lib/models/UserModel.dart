// ignore_for_file: file_names

class Users {
  dynamic id;
  String? name;
  String? status;
  String? email;
  String? gender;

  Users.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    email = json['email'];
    id = json['id'];
    gender = json['gender'];
  }
}
