import 'package:hive/hive.dart';

part 'komentar.g.dart';

@HiveType(typeId: 0)
class Komentar extends HiveObject {
  @HiveField(0)
  final String resepId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String komentar;

  Komentar({
    required this.resepId,
    required this.username,
    required this.komentar,
  });
}
