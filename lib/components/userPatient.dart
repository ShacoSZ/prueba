class userPatienClass {
  final String name;
  final String secondName;
  final String lastName;
  final String motherLastName;
  final String rfc;
  final String genre;
  final String email;
  final String phone;
  final String address;
  final String pasword;
  final String bloodType;
  final double weight;
  final double height;
  final String medicines;
  final DateTime birthDate;

  userPatienClass(
      {required this.name,
      required this.secondName,
      required this.lastName,
      required this.motherLastName,
      required this.rfc,
      required this.genre,
      required this.email,
      required this.phone,
      required this.address,
      required this.pasword,
      required this.bloodType,
      required this.weight,
      required this.height,
      required this.medicines,
      required this.birthDate});

  factory userPatienClass.fromJson(Map<String, dynamic> json) {
    return userPatienClass(
        name: json['name'],
        secondName: json['secondName'],
        lastName: json['lastName'],
        motherLastName: json['motherLastName'],
        rfc: json['rfc'],
        genre: json['genre'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        pasword: json['pasword'],
        bloodType: json['bloodType'],
        weight: json['weight'],
        height: json['height'],
        medicines: json['medicines'],
        birthDate: json['birthDate']);
  }
}
