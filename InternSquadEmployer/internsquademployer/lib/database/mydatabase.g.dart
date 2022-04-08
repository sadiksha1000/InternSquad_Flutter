// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mydatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  InternshipDao? _internshipDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Internships` (`pk` INTEGER PRIMARY KEY AUTOINCREMENT, `id` TEXT, `title` TEXT, `workEnvironment` TEXT, `startDate` TEXT, `duration` TEXT, `stipend` TEXT, `deadline` TEXT, `internshipDetails` TEXT, `skills` TEXT, `whoCanApply` TEXT, `perks` TEXT, `numberOfOpenings` TEXT, `department` TEXT, `internshipType` TEXT, `eid` TEXT, `companyName` TEXT, `companyProfile` TEXT, `address` TEXT, `email` TEXT, `phone` TEXT, `image` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  InternshipDao get internshipDao {
    return _internshipDaoInstance ??= _$InternshipDao(database, changeListener);
  }
}

class _$InternshipDao extends InternshipDao {
  _$InternshipDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _internshipsInsertionAdapter = InsertionAdapter(
            database,
            'Internships',
            (Internships item) => <String, Object?>{
                  'pk': item.pk,
                  'id': item.id,
                  'title': item.title,
                  'workEnvironment': item.workEnvironment,
                  'startDate': item.startDate,
                  'duration': item.duration,
                  'stipend': item.stipend,
                  'deadline': item.deadline,
                  'internshipDetails': item.internshipDetails,
                  'skills': item.skills,
                  'whoCanApply': item.whoCanApply,
                  'perks': item.perks,
                  'numberOfOpenings': item.numberOfOpenings,
                  'department': item.department,
                  'internshipType': item.internshipType,
                  'eid': item.eid,
                  'companyName': item.companyName,
                  'companyProfile': item.companyProfile,
                  'address': item.address,
                  'email': item.email,
                  'phone': item.phone,
                  'image': item.image
                }),
        _internshipsDeletionAdapter = DeletionAdapter(
            database,
            'Internships',
            ['pk'],
            (Internships item) => <String, Object?>{
                  'pk': item.pk,
                  'id': item.id,
                  'title': item.title,
                  'workEnvironment': item.workEnvironment,
                  'startDate': item.startDate,
                  'duration': item.duration,
                  'stipend': item.stipend,
                  'deadline': item.deadline,
                  'internshipDetails': item.internshipDetails,
                  'skills': item.skills,
                  'whoCanApply': item.whoCanApply,
                  'perks': item.perks,
                  'numberOfOpenings': item.numberOfOpenings,
                  'department': item.department,
                  'internshipType': item.internshipType,
                  'eid': item.eid,
                  'companyName': item.companyName,
                  'companyProfile': item.companyProfile,
                  'address': item.address,
                  'email': item.email,
                  'phone': item.phone,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Internships> _internshipsInsertionAdapter;

  final DeletionAdapter<Internships> _internshipsDeletionAdapter;

  @override
  Future<List<Internships>> getAllInternships() async {
    return _queryAdapter.queryList('Select * from Internship',
        mapper: (Map<String, Object?> row) => Internships(
            pk: row['pk'] as int?,
            id: row['id'] as String?,
            title: row['title'] as String?,
            workEnvironment: row['workEnvironment'] as String?,
            deadline: row['deadline'] as String?,
            startDate: row['startDate'] as String?,
            duration: row['duration'] as String?,
            stipend: row['stipend'] as String?,
            department: row['department'] as String?,
            eid: row['eid'] as String?,
            internshipDetails: row['internshipDetails'] as String?,
            internshipType: row['internshipType'] as String?,
            numberOfOpenings: row['numberOfOpenings'] as String?,
            perks: row['perks'] as String?,
            skills: row['skills'] as String?,
            whoCanApply: row['whoCanApply'] as String?,
            address: row['address'] as String?,
            companyName: row['companyName'] as String?,
            companyProfile: row['companyProfile'] as String?,
            email: row['email'] as String?,
            image: row['image'] as String?,
            phone: row['phone'] as String?));
  }

  @override
  Future<Internships?> findInternshipById(int id) async {
    return _queryAdapter.query('Select from Internship where id= ?1',
        mapper: (Map<String, Object?> row) => Internships(
            pk: row['pk'] as int?,
            id: row['id'] as String?,
            title: row['title'] as String?,
            workEnvironment: row['workEnvironment'] as String?,
            deadline: row['deadline'] as String?,
            startDate: row['startDate'] as String?,
            duration: row['duration'] as String?,
            stipend: row['stipend'] as String?,
            department: row['department'] as String?,
            eid: row['eid'] as String?,
            internshipDetails: row['internshipDetails'] as String?,
            internshipType: row['internshipType'] as String?,
            numberOfOpenings: row['numberOfOpenings'] as String?,
            perks: row['perks'] as String?,
            skills: row['skills'] as String?,
            whoCanApply: row['whoCanApply'] as String?,
            address: row['address'] as String?,
            companyName: row['companyName'] as String?,
            companyProfile: row['companyProfile'] as String?,
            email: row['email'] as String?,
            image: row['image'] as String?,
            phone: row['phone'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteInternship(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Internship where id = ?1', arguments: [id]);
  }

  @override
  Future<int> insertInternship(Internships internship) {
    return _internshipsInsertionAdapter.insertAndReturnId(
        internship, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAll(List<Internships> list) {
    return _internshipsDeletionAdapter.deleteListAndReturnChangedRows(list);
  }
}
