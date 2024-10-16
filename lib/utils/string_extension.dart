extension StringModifier on String {
  String capitalize() {
    if (length > 1) {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    } else {
      return toUpperCase();
    }
  }

  String ellipsis([int max = 10]) {
    if (length <= max) return this;
    return "${substring(0, max - 3)}...";
  }
}
