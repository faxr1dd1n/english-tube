// import 'package:en_tube/src/constraints/app_color.dart';
// import 'package:en_tube/src/service/database_service.dart';
// import 'package:flutter/material.dart';

// class DatabasePage extends StatefulWidget {
//   const DatabasePage({super.key});

//   @override
//   State<DatabasePage> createState() => _DatabasePageState();
// }

// class _DatabasePageState extends State<DatabasePage> {
//   final DatabaseService databaseService = DatabaseService.instannce;
//   String? task = null;
//   TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder(
//         future: databaseService.getTasks(),
//         builder: (context, snapshot) {
//           return ListView.builder(
//             itemCount: snapshot.data?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: EdgeInsets.all(12),
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: AppColor.blue,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Task ID: '${snapshot.data![index].id.toString()}'",
//                       style: TextStyle(
//                         color: AppColor.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "Task status: '${snapshot.data![index].status}'",
//                       style: TextStyle(
//                         color: AppColor.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "Task: '${snapshot.data![index].task}'",
//                       style: TextStyle(
//                         color: AppColor.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text('Add task'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: controller,
//                     decoration: InputDecoration(
//                       hintText: 'Add task',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       if (controller.text != '') {
//                         databaseService.addTask(controller.text);
//                         controller.clear();
//                         setState(() {});
//                         Navigator.pop(context);
//                       }
//                     },
//                     child: Text('Save'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
