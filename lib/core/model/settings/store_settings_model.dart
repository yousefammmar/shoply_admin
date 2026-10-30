class StoreSettingsModel {
  final String storeName;
  final String contactEmail;
  final String contactPhone;
  final String address;
  final double shippingFee;
  final double freeShippingOver;
  final List<String> paymentMethods;

  StoreSettingsModel({
    required this.storeName,
    required this.contactEmail,
    required this.contactPhone,
    required this.address,
    required this.shippingFee,
    required this.freeShippingOver,
    required this.paymentMethods,
  });

  factory StoreSettingsModel.fromMap(Map<String, dynamic> json) {
    return StoreSettingsModel(
      storeName: json['storeName'] ?? 'Shoply',
      contactEmail: json['contactEmail'] ?? '',
      contactPhone: json['contactPhone'] ?? '',
      address: json['address'] ?? '',
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0.0,
      freeShippingOver: (json['freeShippingOver'] as num?)?.toDouble() ?? 0.0,
      paymentMethods: List<String>.from(
        json['paymentMethods'] ?? ['Cash on delivery'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'address': address,
      'shippingFee': shippingFee,
      'freeShippingOver': freeShippingOver,
      'paymentMethods': paymentMethods,
    };
  }
}
