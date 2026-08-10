List<T> centerFirst<T>(List<T> items) {
  final result = <T>[];
  for (var i = 0; i < items.length; i++) {
    if (i.isEven) {
      result.add(items[i]);
    } else {
      result.insert(0, items[i]);
    }
  }
  return result;
}
