import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p ;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:drift/native.dart';

part 'local_database.g.dart';

class FavoriteShoes extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get shoeId => integer()();
  TextColumn get title => text()();
  TextColumn get image => text()();
  RealColumn get price => real()();
  RealColumn get ratings => real()();
  IntColumn get isFavorite => integer()();
}

class CartItems extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get shoeTitle => text()();
  TextColumn get image => text()();
  TextColumn get color => text()();
  RealColumn get price => real()();
  IntColumn get shoeSize => integer()();
  IntColumn get quantity => integer()();
}

@DriftDatabase(tables: [
  FavoriteShoes,
  CartItems,
])
class AppDatabase extends _$AppDatabase{
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration{
    return MigrationStrategy(
        onCreate: (Migrator m)async{
          await m.createAll();
        },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if(Platform.isAndroid){
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cacheBase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cacheBase;
    return NativeDatabase.createInBackground(file);

  });
}
