class AgeGroup {
  final int lowerBound;
  final int upperBound;

  AgeGroup(this.lowerBound, this.upperBound);

  @override
  String toString() {
    return '$lowerBound years to $upperBound years';
  }
}
