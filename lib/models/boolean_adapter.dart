import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class BooleanAdapter extends TypeAdapter<bool> {
  @override
  final typeId = 1;

  @override
  bool read(BinaryReader reader) {
    return reader.readBool();
  }

  @override
  void write(BinaryWriter writer, bool obj) {
    writer.writeBool(obj);
  }
}

