import 'package:floor/floor.dart';
import 'package:internsquad/entity/internship.dart';

@dao
abstract class InternshipDao {
  @Query('Select * from Internship')
  Future<List<Internships>> getAllInternships();

  @Query('Select from Internship where id= :id')
  Future<Internships?> findInternshipById(int id);

  @insert
  Future<int> insertInternship(Internships internship);

  @Query("delete from Internship where id = :id")
  Future<void> deleteInternship(int id);

  @delete
  Future<int> deleteAll(List<Internships> list);
}
