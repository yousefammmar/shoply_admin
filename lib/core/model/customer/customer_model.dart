class CustomerModel {
  final String uid;
  final String email;
  final String fullName;
  final String userName;
  final String address;
  final String profileImage;

  CustomerModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.userName,
    required this.address,
    required this.profileImage,
  });

  factory CustomerModel.fromFirestore(String uid, Map<String, dynamic> json) {
    return CustomerModel(
      uid: uid,
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      address: json['address'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }
}
