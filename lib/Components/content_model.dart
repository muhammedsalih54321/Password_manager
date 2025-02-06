class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Manage All Passwords',
      image: 'assets/images/onboard1.png',
      discription:
          "Brigade is offline and we do not store your data on our server. Your data is saved offline on your device and you can sync your data in your online cloud."),
  UnbordingContent(
      title: 'We Store For You',
      image: 'assets/images/onboard2.png',
      discription:
          "We store your logins, IDs, and payment information in your vault. Just remember a master password and forget other things and its offline."),
  UnbordingContent(
      title: 'Lock Your Files',
      image: 'assets/images/onboard3.png',
      discription:
          "You can lock your files based on priority that is set by you. Brigade supports type based file security maintenance."),
  UnbordingContent(
      title: 'Save Your Cards',
      image: 'assets/images/onboard4.png',
      discription:
          "Save your card information including bank holdings. Don’t worry we don’t have any permission to look through your saved informations."),
];
