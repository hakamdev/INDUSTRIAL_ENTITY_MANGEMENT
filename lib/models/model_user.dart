
class ModelUser {
  int? id;
  String? firstName;
  String? lastName;
  String? matricule;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? shouldChangePassword;

  ModelUser({
    this.id,
    this.firstName,
    this.lastName,
    this.matricule,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.shouldChangePassword,
  });

  ModelUser copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? matricule,
    String? email,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? shouldChangePassword,
  }) =>
      ModelUser(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        matricule: matricule ?? this.matricule,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shouldChangePassword: shouldChangePassword ?? this.shouldChangePassword,
      );

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    matricule: json["matricule"],
    email: json["email"],
    phone: json["phone"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    shouldChangePassword: json["shouldChangePassword"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "matricule": matricule,
    "email": email,
    "phone": phone,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "shouldChangePassword": shouldChangePassword,
  };
}
