class Topping {
  final String name;
  final double price;
  final String url;

  const Topping({
    required this.name,
    required this.price,
    required this.url,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Topping &&
        other.name == name &&
        other.price == price &&
        other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ url.hashCode;
}
