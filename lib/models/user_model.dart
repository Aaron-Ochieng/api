// ignore_for_file: non_constant_identifier_names

class Author {
  String username;
  String? profile_img_url;
  bool verified;
  Author({
    required this.username,
    this.profile_img_url,
    required this.verified,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        username: json['username'],
        profile_img_url: json['profile_img_url'],
        verified: json['verified'],
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'profile_img_url': profile_img_url,
        'verified': verified,
      };
}
