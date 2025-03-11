import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediclic/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key:_formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          border: OutlineInputBorder()),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Email is required';
                            } else{
                              return null;
                            }
                          }
                    ),
                    SizedBox(height: 20,),
                     TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Passwordl",
                          border: OutlineInputBorder()),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Password is required';
                            } else{
                              return null;
                            }
                          }
                    ),
                   Container(
                    margin: EdgeInsets.only(top: 30),
                    width: double.infinity ,
                    child: 
                     ElevatedButton(
                      
                      onPressed: () async{
if (_formkey.currentState!.validate()){
try{
  await Auth().loginWithEmailAndPassword(
    _emailController.text,
    _passwordController.text
  );
} on FirebaseAuthException catch (e){
  //message d'erreur
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text("${e.message}"),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red ,
     showCloseIcon: true,)
    );
   
}
}
                      }
                    , child: Text("connexion")),
                   )
                  ]),
            )
            )
            );
  }
}
