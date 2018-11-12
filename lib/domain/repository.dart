class Repository {
  String name;
  String description;
  String owner;
  String avatarUrl;
  int forks;
  int stars;
  int watchers;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  String language;

  Repository(
      {this.name,
      this.description,
      this.owner,
      this.avatarUrl,
      this.forks,
      this.stars,
      this.watchers,
      this.createdAt,
      this.updatedAt,
      this.url,
      this.language});

  static Repository fromJson(Map data) {
    return Repository(
      name: data["name"],
      description: data["description"],
      owner: data["owner"]["login"],
      avatarUrl: data["owner"]["avatar_url"],
      stars: data["stargazers_count"],
      forks: data["forks_count"],
      watchers: data["watchers_count"],
      createdAt: DateTime.parse(data["created_at"]),
      updatedAt: DateTime.parse(data["updated_at"]),
      url: data["html_url"],
      language: data["language"],
    );
  }
}
