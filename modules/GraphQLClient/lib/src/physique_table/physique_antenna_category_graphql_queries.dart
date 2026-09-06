/// Requests the default category-to-antenna grouping the physique table
/// editor uses to build its pickers (see `PhysiqueAntennaCategoryEntity`
/// on the server). Deliberately kept separate from [masterDataQuery]:
/// this data isn't part of the app's gameplay [MasterData] domain model,
/// it only feeds the developer-only physique table screens.
const physiqueAntennaCategoriesQuery = r'''
query PhysiqueAntennaCategories {
  masterData {
    physiqueAntennaCategories {
      category
      anntenaCategory
    }
    physiqueStatusCategories {
      name
      columnCount
    }
    physiqueAntennaCategoryAntennaLinks {
      major
      minor
      antennaId
      antennaName
    }
  }
}
''';
