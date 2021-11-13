extension StringCasingExtension on String {
  String firstToCap() =>
      this.length > 0 ? "${this[0].toUpperCase()}${this.substring(1)}" : "";
  String toTitleCase() => this
      .replaceAll(RegExp(" +"), " ")
      .split(" ")
      .map((str) => str.firstToCap())
      .join(" ");
}
