import 'dart:math';

int generateOrderId() {
  var rng = Random();
  int orderId = rng.nextInt(999999);
  return orderId;
}