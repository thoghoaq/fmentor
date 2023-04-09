class PaymentResponseModel {
  final String orderDescription;
  final String transactionId;
  final String orderId;
  final String paymentMethod;
  final String paymentId;
  final bool success;
  final String token;
  final String vnPayResponseCode;

  PaymentResponseModel({
    required this.orderDescription,
    required this.transactionId,
    required this.orderId,
    required this.paymentMethod,
    required this.paymentId,
    required this.success,
    required this.token,
    required this.vnPayResponseCode,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      orderDescription: json['orderDescription'],
      transactionId: json['transactionId'],
      orderId: json['orderId'],
      paymentMethod: json['paymentMethod'],
      paymentId: json['paymentId'],
      success: json['success'],
      token: json['token'],
      vnPayResponseCode: json['vnPayResponseCode'],
    );
  }
}
