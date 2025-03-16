// user_management_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediclic/services/auth_service.dart';

class UserManagementPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  // Fonction pour obtenir tous les utilisateurs
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Erreur lors de la récupération des utilisateurs: $e');
      return [];
    }
  }

  // Fonction pour changer le rôle d'un utilisateur
  Future<bool> changeUserRole(String userId, String newRole) async {
    try {
      await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'role': newRole});
      return true;
    } catch (e) {
      print('Erreur lors du changement de rôle: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Utilisateurs'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          
          List<Map<String, dynamic>> users = snapshot.data ?? [];
          
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> user = users[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(user['nom'] ?? 'Sans nom'),
                  subtitle: Text(user['email'] ?? ''),
                  trailing: DropdownButton<String>(
                    value: user['role'],
                    items: [
                      DropdownMenuItem(value: 'user', child: Text('Utilisateur')),
                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    ],
                    onChanged: (String? newRole) async {
                      if (newRole != null) {
                        bool success = await changeUserRole(user['uid'], newRole);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Rôle modifié avec succès')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Erreur lors de la modification du rôle')),
                          );
                        }
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}