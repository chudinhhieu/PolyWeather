class Convert{
  String fahrenheitToCelsius(double fahrenheit) {
    double celsius = (fahrenheit - 32) * 5 / 9;

    if (celsius % 1 == 0) {
      return celsius.toInt().toString();
    } else {
      return celsius.toStringAsFixed(1);
    }
  }
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}