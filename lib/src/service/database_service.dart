// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// class DatabaseService {
//   static Database? _db;
//   static final DatabaseService instannce = DatabaseService._constructor();
//   final String _tasksTableName = "tasks";
//   final String _tasksIdColumnName = "id";
//   final String _tasksContentColumnName = "task";
//   final String _tasksStatusColumnName = "status";

//   DatabaseService._constructor();
//   //getter
//   Future<Database> get databaseGetter async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await getDatabase();
//     return _db!;
//   }

//   //methods
//   Future<Database> getDatabase() async {
//     final databaseDirPath = await getDatabasesPath();
//     final databasePath = join(databaseDirPath, "my_database.db");
//     final database = await openDatabase(
//       databasePath,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//         CREATE TABLE $_tasksTableName (
//           $_tasksIdColumnName INTEGER PRIMARY KEY,
//           $_tasksContentColumnName TEXT NOT NULL,
//           $_tasksStatusColumnName INTEGER NOT NULL
//         )
//       ''');
//       },
//     );
//     return database;
//   }

//   Future<List<Task>> getTasks() async {
//     final db = await databaseGetter;
//     final data = await db.query(_tasksTableName);
//     List<Task> tasks = data
//         .map(
//           (e) => Task(
//             id: e["id"] as int,
//             status: e["status"] as int,
//             task: e["task"] as String,
//           ),
//         )
//         .toList();
//     return tasks;
//   }

//   void addTask(String task) async {
//     final db = await databaseGetter;
//     await db.insert(_tasksTableName, {
//       _tasksContentColumnName: task,
//       _tasksStatusColumnName: 0,
//     });
//   }
// }

// class Task {
//   final int status, id;
//   final String task;

//   Task({required this.id, required this.status, required this.task});
// }
