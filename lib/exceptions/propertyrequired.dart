class PropertyRequired implements Exception {
  String property;

  PropertyRequired(this.property);

  @override
  String toString() {
    // TODO: implement toString
  return 'Property ${this.property} is required ' ;
  }
}
