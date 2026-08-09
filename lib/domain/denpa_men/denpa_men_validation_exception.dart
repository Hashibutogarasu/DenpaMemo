/// Base type for validation failures raised by `createDenpaMen`.
abstract class DenpaMenValidationException implements Exception {
  const DenpaMenValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class InvalidBodyColorCountException extends DenpaMenValidationException {
  const InvalidBodyColorCountException(this.bodyColorCount)
    : super('bodyColors must contain exactly 1 or 2 colors, got $bodyColorCount');

  final int bodyColorCount;
}

class SpColorRequiresSingleBodyColorException
    extends DenpaMenValidationException {
  const SpColorRequiresSingleBodyColorException()
    : super('isSpColor can only be true when bodyColors has exactly 1 color');
}

class UnknownBodyColorException extends DenpaMenValidationException {
  const UnknownBodyColorException(this.colorId)
    : super('Unknown body color id: $colorId');

  final String colorId;
}

class InvalidParentCountException extends DenpaMenValidationException {
  const InvalidParentCountException(this.parentCount)
    : super('parentIds must contain exactly 0 or 2 entries, got $parentCount');

  final int parentCount;
}
