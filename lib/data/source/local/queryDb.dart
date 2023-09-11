import 'package:app/data/source/local/model/notification.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Connect to DB
Future<dynamic> connectDb() async{
  final database = openDatabase(join(await getDatabasesPath(), 'notification.db'));
  return database;
}

Future<void> insertNotifications(Notification notification) async {
  final db = await connectDb();

  await db.insert(
    'notification',
    notification.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Notification>> getNotification() async {
  final db = await connectDb();

  final List<Map<String, dynamic>> maps = await db.query('notification');

  var list =  List.generate(maps.length, (i) {
    return Notification(
        notifId: maps[i]['notifId'],
        isRead: maps[i]['isRead'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        category: maps[i]['category'],
        tanggal: maps[i]['tanggal'],
        topic: maps[i]['topic']
    );
  });
  return list;
}

Future<void> updateNotification(Notification notification) async {
  final db = await connectDb();

  //Modified variable for isRead
  var notifNow = Notification(
    notifId: notification.notifId,
    isRead: 1,
    title: notification.title,
    body: notification.body,
    category: notification.category,
    tanggal: notification.tanggal,
    topic: notification.topic,
  );

  await db.update(
    'notification',
    notifNow.toMap(),
    where: 'notifId = ?',
    whereArgs: [notification.notifId],
  );
}

Future<void> deleteNotification(Notification notification) async {
  final db = await connectDb();

  await db.delete(
      'notification',
      where: 'notifId = ?',
      whereArgs: [notification.notifId]
  );
  //getNotification();
}

Future<dynamic> getUnreadNotification() async{
  final db = await connectDb();

  var count = await db.rawQuery('SELECT COUNT(*) FROM notification WHERE isRead = ?', [0]);
  return count;
}