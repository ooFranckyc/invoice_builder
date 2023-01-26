class Item {
  String name;
  int qty;
  double price;
  Item({
    required this.name,
    required this.qty,
    required this.price,
  });
  // Return a list of each item present in list with all perfom calcul
  List<String> toList() =>
      [name, "$qty", "\$${price.toStringAsFixed(2)}", ((price * qty).toStringAsFixed(2))];
}
