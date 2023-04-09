class PaymentRequestModel {
  String orderType;
  double amount;
  String orderDescription;
  String name;

  PaymentRequestModel({
    required this.orderType,
    required this.amount,
    required this.orderDescription,
    required this.name,
  });

  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      orderType: json['orderType'],
      amount: json['amount'],
      orderDescription: json['orderDescription'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderType'] = orderType;
    data['amount'] = amount;
    data['orderDescription'] = orderDescription;
    data['name'] = name;
    return data;
  }
}
