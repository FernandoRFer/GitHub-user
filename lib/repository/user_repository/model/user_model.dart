class UserModel {
  final int id;
  final int? publicRepos;
  final int? publicGists;
  final int? followers;
  final int? following;
  final bool? siteAdmin;
  final bool? hireable;
  final String login;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final String bio;
  final String twitterUsername;
  final String createdAt;
  final String updatedAt;

  UserModel(
      {required this.id,
      required this.login,
      required this.nodeId,
      required this.avatarUrl,
      required this.gravatarId,
      required this.url,
      required this.htmlUrl,
      required this.followersUrl,
      required this.followingUrl,
      required this.gistsUrl,
      required this.starredUrl,
      required this.subscriptionsUrl,
      required this.organizationsUrl,
      required this.reposUrl,
      required this.eventsUrl,
      required this.receivedEventsUrl,
      required this.type,
      this.siteAdmin,
      required this.name,
      required this.company,
      required this.blog,
      required this.location,
      required this.email,
      this.hireable,
      required this.bio,
      required this.twitterUsername,
      this.publicRepos,
      this.publicGists,
      this.followers,
      this.following,
      required this.createdAt,
      required this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json)
      : login = json['login'] ?? "",
        id = json['id'] ?? 0,
        nodeId = json['node_id'] ?? "",
        avatarUrl = json['avatar_url'] ?? "",
        gravatarId = json['gravatar_id'] ?? "",
        url = json['url'] ?? "",
        htmlUrl = json['html_url'] ?? "",
        followersUrl = json['followers_url'] ?? "",
        followingUrl = json['following_url'] ?? "",
        gistsUrl = json['gists_url'] ?? "",
        starredUrl = json['starred_url'] ?? "",
        subscriptionsUrl = json['subscriptions_url'] ?? "",
        organizationsUrl = json['organizations_url'] ?? "",
        reposUrl = json['repos_url'] ?? "",
        eventsUrl = json['events_url'] ?? "",
        receivedEventsUrl = json['received_events_url'] ?? "",
        type = json['type'] ?? "",
        siteAdmin = json['site_admin'],
        name = json['name'] ?? "",
        company = json['company'] ?? "",
        blog = json['blog'] ?? "",
        location = json['location'] ?? "",
        email = json['email'] ?? "",
        hireable = json['hireable'],
        bio = json['bio'] ?? "",
        twitterUsername = json['twitter_username'] ?? "",
        publicRepos = json['public_repos'],
        publicGists = json['public_gists'],
        followers = json['followers'],
        following = json['following'],
        createdAt = json['created_at'] ?? "",
        updatedAt = json['updated_at'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['followers_url'] = followersUrl;
    data['following_url'] = followingUrl;
    data['gists_url'] = gistsUrl;
    data['starred_url'] = starredUrl;
    data['subscriptions_url'] = subscriptionsUrl;
    data['organizations_url'] = organizationsUrl;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['received_events_url'] = receivedEventsUrl;
    data['type'] = type;
    data['site_admin'] = siteAdmin;
    data['name'] = name;
    data['company'] = company;
    data['blog'] = blog;
    data['location'] = location;
    data['email'] = email;
    data['hireable'] = hireable;
    data['bio'] = bio;
    data['twitter_username'] = twitterUsername;
    data['public_repos'] = publicRepos;
    data['public_gists'] = publicGists;
    data['followers'] = followers;
    data['following'] = following;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
