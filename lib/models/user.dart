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
  Child({required String uid, String? name, String? email})
      : super(uid: uid, name: name, email: email);
}
