enum UserRole {
  shipper,
  hubManager,
  driver,
  admin;

  String get displayName {
    switch (this) {
      case UserRole.shipper:
        return 'Shipper';
      case UserRole.hubManager:
        return 'Hub Manager';
      case UserRole.driver:
        return 'Delivery Driver';
      case UserRole.admin:
        return 'System Administrator';
    }
  }

  static UserRole fromString(String val) {
    switch (val.toLowerCase()) {
      case 'hub_manager':
      case 'hubmanager':
        return UserRole.hubManager;
      case 'driver':
        return UserRole.driver;
      case 'admin':
        return UserRole.admin;
      case 'shipper':
      default:
        return UserRole.shipper;
    }
  }

  String toDbString() {
    switch (this) {
      case UserRole.hubManager:
        return 'hub_manager';
      case UserRole.driver:
        return 'driver';
      case UserRole.admin:
        return 'admin';
      case UserRole.shipper:
        return 'shipper';
    }
  }
}

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String phone;
  final UserRole role;
  final String? hubId;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.role,
    this.hubId,
    this.avatarUrl,
  });

  bool get isHubManager => role == UserRole.hubManager;
  bool get isShipper => role == UserRole.shipper;
  bool get isDriver => role == UserRole.driver;

  UserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    UserRole? role,
    String? hubId,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      hubId: hubId ?? this.hubId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'phone': phone,
        'role': role.toDbString(),
        'hub_id': hubId,
        'avatar_url': avatarUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: UserRole.fromString(json['role'] as String? ?? 'shipper'),
      hubId: json['hub_id'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }
}
