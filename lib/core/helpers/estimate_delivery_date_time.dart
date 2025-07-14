DateTime estimateDeliveryDateTime(DateTime orderDateTime) {
  const minutesToDelivery = 2;

  DateTime deliveryDateTime = orderDateTime.add(
    const Duration(minutes: minutesToDelivery),
  );

  return deliveryDateTime;
}
