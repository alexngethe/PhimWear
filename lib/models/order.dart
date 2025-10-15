class Order {
  final String orderId;
  final String businessName;
  final List<Map<String, dynamic>> items;
  final double total;
  final DeliveryDetails delivery;
  final String notes;
  final String status;
  final bool webClient;
  final DateTime createdAt;

  Order({
    required this.orderId,
    required this.businessName,
    required this.items,
    required this.total,
    required this.delivery,
    required this.notes,
    this.status = 'pending',
    this.webClient = true,
    required this.createdAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'businessName': businessName,
      'items': items,
      'total': total,
      'delivery': delivery.toMap(),
      'notes': notes,
      'status': status,
      'webClient': webClient,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class DeliveryDetails {
  final String fullName;
  final String phone;
  final String address;
  final String city;
  final String postalCode;

  DeliveryDetails({
    required this.fullName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'postalCode': postalCode,
    };
  }
}
