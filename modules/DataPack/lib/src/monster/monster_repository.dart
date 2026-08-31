import 'monster.dart';

abstract class MonsterRepository {
  Future<List<Monster>> load();
}
