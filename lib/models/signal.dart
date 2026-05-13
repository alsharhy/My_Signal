class Signal {
  final int id;
  final String title;
  final String urlImage;
  final String? description;
  final String urlImageMean;


  const Signal({
    required this.id,
    required this.title,
    required this.urlImageMean,
    required this.urlImage,
    this.description,
  
  });
}
