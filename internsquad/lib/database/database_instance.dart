import '../database/mydatabase.dart';

class DatabaseInstance {
  static DatabaseInstance? _instance;

  DatabaseInstance._();
  static DatabaseInstance get instance => _instance ??= DatabaseInstance._();

  Future<AppDataBase> getDatabaseInstance() {
    return $FloorAppDataBase.databaseBuilder('mydatabase.db').build();
  }
}
