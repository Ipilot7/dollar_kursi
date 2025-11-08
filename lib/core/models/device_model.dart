// To parse this JSON data, do
//
//     final deviceModel = deviceModelFromJson(jsonString);

import 'dart:convert';

DeviceModel deviceModelFromJson(String str) => DeviceModel.fromJson(json.decode(str));

String deviceModelToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
    final int id;
    final String deviceId;
    final String fcmToken;
    final DateTime createdAt;
    final DateTime updatedAt;

    DeviceModel({
        required this.id,
        required this.deviceId,
        required this.fcmToken,
        required this.createdAt,
        required this.updatedAt,
    });

    DeviceModel copyWith({
        int? id,
        String? deviceId,
        String? fcmToken,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        DeviceModel(
            id: id ?? this.id,
            deviceId: deviceId ?? this.deviceId,
            fcmToken: fcmToken ?? this.fcmToken,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json["id"],
        deviceId: json["device_id"],
        fcmToken: json["fcm_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "fcm_token": fcmToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
