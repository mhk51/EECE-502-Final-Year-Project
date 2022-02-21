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

enum gender { Male, Female }

class Child extends CustomUser {
  final int age;
  final int weight;
  final int height;
  final String gender;
  Child(
      {required String uid,
      String? name,
      String? email,
      required this.age,
      required this.height,
      required this.weight,
      required this.gender})
      : super(uid: uid, name: name, email: email);
}
