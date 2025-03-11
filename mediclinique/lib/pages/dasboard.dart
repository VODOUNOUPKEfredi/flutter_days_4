// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
       
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Dasboard(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class Dasboard extends StatefulWidget {
//   const Dasboard({super.key, required this.title});


//   final String title;

//   @override
//   State<Dasboard> createState() => _DasboardState();
// }

// class _DasboardState extends State<Dasboard> {
//   int _counter = 0;

 

//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       appBar: AppBar(
        
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
        
//         child: Column(
//           children: [
//             Row(children: [Text("Dashboard")],),
//             Row(
//               children: [
//                 Container(
//                   decoration: 
//                   BoxDecoration(
//                     border: 
//                   ),
//                   child: Column(
//                     children: [
//                       Text("Rendez-vous aujourd'hui")
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
          
//         ),
//       ),
//        // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }