enum PizzaSize {
  small,
  medium,
  large,
  extraLarge,
}

String formatPizzaSize(PizzaSize size) {
  return size
      .toString()
      .split('.')
      .last
      .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'), (match) => '${match[1]} ${match[2]}')
      .replaceFirstMapped(RegExp(r'^\w'), (match) => match[0]!.toUpperCase());
}
