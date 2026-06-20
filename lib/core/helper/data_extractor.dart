class DataExtractor {
 static int extractInt(String? value) {
    if (value == null || value.isEmpty) return 0;

    final number = value.replaceAll(RegExp(r'[^0-9]'), '');

    return int.tryParse(number) ?? 0;
  }

}