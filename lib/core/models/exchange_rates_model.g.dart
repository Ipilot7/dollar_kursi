// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rates_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeRatesModelAdapter extends TypeAdapter<ExchangeRatesModel> {
  @override
  final int typeId = 0;

  @override
  ExchangeRatesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExchangeRatesModel(
      lastDate: fields[0] as String?,
      data: (fields[1] as List?)?.cast<BankModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExchangeRatesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lastDate)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRatesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankModelAdapter extends TypeAdapter<BankModel> {
  @override
  final int typeId = 1;

  @override
  BankModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankModel(
      bank: fields[0] as Bank?,
      buy: fields[1] as int?,
      sell: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BankModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bank)
      ..writeByte(1)
      ..write(obj.buy)
      ..writeByte(2)
      ..write(obj.sell);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankAdapter extends TypeAdapter<Bank> {
  @override
  final int typeId = 2;

  @override
  Bank read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bank(
      name: fields[0] as String?,
      slug: fields[1] as String?,
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Bank obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.slug)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
