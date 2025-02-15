import 'package:hive/hive.dart';

import 'Model_class.dart';

class PasswordEntryAdapter extends TypeAdapter<PasswordEntry> {
  @override
  final int typeId = 0;

  @override
  PasswordEntry read(BinaryReader reader) {
    return PasswordEntry(
      appName: reader.readString(),
      appIcon: reader.readString(),
      emailPhone: reader.readString(),
      password: reader.readString(),
      category: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PasswordEntry obj) {
    writer.writeString(obj.appName);
    writer.writeString(obj.appIcon);
    writer.writeString(obj.emailPhone);
    writer.writeString(obj.password);
    writer.writeString(obj.category);
  }
}
