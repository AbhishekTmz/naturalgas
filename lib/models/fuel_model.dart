class FuelModel {
  final double rate;
  final double quantity;
  FuelModel({
    required this.rate,
    required this.quantity,
  });

  getTotalPrice() => rate * quantity;
}
