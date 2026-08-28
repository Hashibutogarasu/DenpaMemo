import '../qr_code/qr_code_record.dart';
import 'denpa_men_catch_order.dart';
import 'denpa_men_record.dart';

abstract class BirthGuideException implements Exception {
  const BirthGuideException(this.message);

  final String message;

  @override
  String toString() => message;
}

class BirthGuideResolutionException extends BirthGuideException {
  const BirthGuideResolutionException(this.missingId)
    : super('Could not resolve id: $missingId');

  final String missingId;
}

sealed class BirthGuideStep {}

class BirthGuideCatchStep extends BirthGuideStep {
  BirthGuideCatchStep({required this.qrCode, required this.individuals});

  final QrCodeRecord qrCode;
  final List<DenpaMenRecord> individuals;
}

class BirthGuideBreedStep extends BirthGuideStep {
  BirthGuideBreedStep({
    required this.individual,
    required this.parentA,
    required this.parentB,
  });

  final DenpaMenRecord individual;
  final DenpaMenRecord parentA;
  final DenpaMenRecord parentB;
}

List<BirthGuideStep> buildBirthGuideSteps({
  required DenpaMenRecord target,
  required List<DenpaMenRecord> allDenpaMen,
  required List<QrCodeRecord> allQrCodes,
}) {
  final denpaMenById = {
    for (final record in allDenpaMen) record.denpaMen.id: record,
  };
  final denpaMenOnlyById = {
    for (final entry in denpaMenById.entries) entry.key: entry.value.denpaMen,
  };
  final qrCodeById = {
    for (final record in allQrCodes) record.qrCode.id: record,
  };

  DenpaMenRecord resolveDenpaMen(String id) {
    final record = denpaMenById[id];
    if (record == null) {
      throw BirthGuideResolutionException(id);
    }
    return record;
  }

  QrCodeRecord resolveQrCode(String id) {
    final record = qrCodeById[id];
    if (record == null) {
      throw BirthGuideResolutionException(id);
    }
    return record;
  }

  final visited = <String>{};
  final order = <String>[];

  void visit(String id) {
    if (!visited.add(id)) {
      return;
    }
    for (final parentId in resolveDenpaMen(id).denpaMen.parentIds) {
      visit(parentId);
    }
    order.add(id);
  }

  visit(target.denpaMen.id);

  final steps = <BirthGuideStep>[];
  final catchStepEmittedForId = <String>{};

  for (final id in order) {
    if (catchStepEmittedForId.contains(id)) {
      continue;
    }
    final record = resolveDenpaMen(id);
    final denpaMen = record.denpaMen;

    if (denpaMen.parentIds.isEmpty) {
      final qrCodeId = denpaMen.qrCodeId;
      if (qrCodeId == null) {
        throw BirthGuideResolutionException(id);
      }
      final qrCode = resolveQrCode(qrCodeId);
      final individuals =
          allDenpaMen
              .where(
                (candidate) =>
                    order.contains(candidate.denpaMen.id) &&
                    candidate.denpaMen.qrCodeId == qrCodeId,
              )
              .toList()
            ..sort(
              (a, b) => (a.denpaMen.newCatchOrder(denpaMenOnlyById) ?? 0)
                  .compareTo(b.denpaMen.newCatchOrder(denpaMenOnlyById) ?? 0),
            );
      for (final individual in individuals) {
        catchStepEmittedForId.add(individual.denpaMen.id);
      }
      steps.add(
        BirthGuideCatchStep(qrCode: qrCode, individuals: individuals),
      );
    } else {
      final parentA = resolveDenpaMen(denpaMen.parentIds[0]);
      final parentB = resolveDenpaMen(denpaMen.parentIds[1]);
      catchStepEmittedForId.add(id);
      steps.add(
        BirthGuideBreedStep(
          individual: record,
          parentA: parentA,
          parentB: parentB,
        ),
      );
    }
  }

  return steps;
}
