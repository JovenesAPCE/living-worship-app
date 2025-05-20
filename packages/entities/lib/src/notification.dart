class Notification {
  final String id;
  final String message;
  final String imageUrl;
  final int row;
  final String dateString;

  const Notification({
    this.id = '',
    this.message = '',
    this.imageUrl = '',
    this.row = 0,
    this.dateString = '',
  });
}