// ignore_for_file: constant_identifier_names

class CustomUser {
  final String uid;
  final String? name;
  final String? email;

  CustomUser({required this.uid, required this.name, required this.email});
}

class Parent extends CustomUser {
  Parent({required String uid, String? name, String? email})
      : super(uid: uid, name: name, email: email);
}

class Child extends CustomUser {
  final int age;
  final int weight;
  final int height;
  final String gender;
  String firstName = "-";
  String lastName = "-";
  Child(
      {required String uid,
      required String? name,
      required String? email,
      required this.age,
      required this.height,
      required this.weight,
      required this.gender})
      : super(uid: uid, name: name, email: email);
}
