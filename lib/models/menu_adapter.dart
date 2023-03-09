//part of 'menu_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:loh_coffee_eatery/models/menu_model.dart';

class MenuAdapter extends TypeAdapter<MenuModel> {
  @override
  int get typeId => 0;

  @override
  MenuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      tag: fields[3] as String,
      price: fields[4] as int,
      image: fields[5] as String,
      totalLoved: fields[6] as int,
      totalOrdered: fields[7] as int,
      quantity: fields[8] as int,
    );
    // TODO: implement read
    //throw UnimplementedError();
  }

  @override
  void write(BinaryWriter writer, MenuModel obj) {
    // TODO: implement write
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.totalLoved)
      ..writeByte(7)
      ..write(obj.totalOrdered)
      ..writeByte(8)
      ..write(obj.quantity);
  }
}