double calculate(String input) {
  double a;
  double b;
  if (input.contains("+")) {
    List<String> values = input.split("+");
    a = calculate(values.elementAt(0) != null ? values.elementAt(0) : "0");
    b = calculate(values.elementAt(1) != null ? values.elementAt(1) : "0");
    return (a + b);
  } else if (input.contains("-")) {
    List<String> values = input.split("-");
    a = calculate(values.elementAt(0) != null ? values.elementAt(0) : "0");
    b = calculate(values.elementAt(1) != null ? values.elementAt(1) : "0");
    return (a - b);
  } else if (input.contains("*")) {
    List<String> values = input.split("*");
    a = calculate(values.elementAt(0) != null ? values.elementAt(0) : "1");
    b = calculate(values.elementAt(1) != null ? values.elementAt(1) : "1");
    return (a * b);
  } else if (input.contains("/")) {
    List<String> values = input.split("/");
    a = calculate(values.elementAt(0) != null ? values.elementAt(0) : "1");
    b = calculate(values.elementAt(1) != null ? values.elementAt(1) : "1");
    return (a / b);
  } else {
    return double.parse(input);
  }
}
