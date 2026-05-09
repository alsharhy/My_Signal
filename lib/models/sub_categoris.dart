 

class SubCategory {
  final int id;
  final String titleSubCatecory;
  final String? urlImage;
  final bool isFavorite;
  

  const SubCategory({
    required this.id,
    required this.titleSubCatecory,
    this.urlImage,
    required this.isFavorite,
  });
}
