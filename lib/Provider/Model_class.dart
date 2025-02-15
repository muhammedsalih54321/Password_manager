import 'package:hive/hive.dart';



@HiveType(typeId: 0)
class PasswordEntry extends HiveObject {
  @HiveField(0)
  String appName;

  @HiveField(1)
  String appIcon;

  @HiveField(2)
  String emailPhone;

  @HiveField(3)
  String password;

  @HiveField(4)
  String category;

  PasswordEntry({
    required this.appName,
    required this.appIcon,
    required this.emailPhone,
    required this.password,
    required this.category,
  });
}
