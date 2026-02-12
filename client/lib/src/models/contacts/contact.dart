import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 10)
class Contact extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  // Canales disponibles
  @HiveField(3)
  final bool whatsappEnabled;

  @HiveField(4)
  final bool smsEnabled;

  @HiveField(5)
  final bool callEnabled;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.whatsappEnabled = true,
    this.smsEnabled = false,
    this.callEnabled = false,
  });

  Contact copyWith({
    String? name,
    String? phone,
    bool? whatsappEnabled,
    bool? smsEnabled,
    bool? callEnabled,
  }) {
    return Contact(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      whatsappEnabled: whatsappEnabled ?? this.whatsappEnabled,
      smsEnabled: smsEnabled ?? this.smsEnabled,
      callEnabled: callEnabled ?? this.callEnabled,
    );
  }
}
