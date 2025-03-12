// user_model.dart
class UserModel {
  final String uid;
  final String nom;
  final String email;
  final String role;

  UserModel({
    required this.uid,
    required this.nom,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      nom: map['nom'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user', // 'user' par défaut
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nom': nom,
      'email': email,
      'role': role,
    };
  }
}