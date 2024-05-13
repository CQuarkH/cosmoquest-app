class Photo {
  final String title;
  final String description;
  final String url;
  final String date;
  final String? copyright;

  Photo(
      {required this.title,
      required this.description,
      required this.url,
      required this.date,
      this.copyright});

  factory Photo.fromJson(Map<String, dynamic> photoData) => Photo(
      title: photoData['title'],
      description: photoData['description'] ?? 'No description available',
      url: photoData['url'],
      date: photoData['date'],
      copyright: photoData['copyright']);
}
