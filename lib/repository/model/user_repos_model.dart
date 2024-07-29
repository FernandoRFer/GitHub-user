class UserReposModel {
  int? id;
  String? nodeId;
  String? name;
  String? fullName;
  Owner? owner;
  bool? private;
  String? htmlUrl;
  String? description;
  bool? fork;
  String? url;
  String? archiveUrl;
  String? assigneesUrl;
  String? blobsUrl;
  String? branchesUrl;
  String? collaboratorsUrl;
  String? commentsUrl;
  String? commitsUrl;
  String? compareUrl;
  String? contentsUrl;
  String? contributorsUrl;
  String? deploymentsUrl;
  String? downloadsUrl;
  String? eventsUrl;
  String? forksUrl;
  String? gitCommitsUrl;
  String? gitRefsUrl;
  String? gitTagsUrl;
  String? gitUrl;
  String? issueCommentUrl;
  String? issueEventsUrl;
  String? issuesUrl;
  String? keysUrl;
  String? labelsUrl;
  String? languagesUrl;
  String? mergesUrl;
  String? milestonesUrl;
  String? notificationsUrl;
  String? pullsUrl;
  String? releasesUrl;
  String? sshUrl;
  String? stargazersUrl;
  String? statusesUrl;
  String? subscribersUrl;
  String? subscriptionUrl;
  String? tagsUrl;
  String? teamsUrl;
  String? treesUrl;
  String? cloneUrl;
  String? mirrorUrl;
  String? hooksUrl;
  String? svnUrl;
  String? homepage;
  String? language;
  int? forksCount;
  int? stargazersCount;
  int? watchersCount;
  int? size;
  String? defaultBranch;
  int? openIssuesCount;
  bool? isTemplate;
  List<String>? topics;
  bool? hasIssues;
  bool? hasProjects;
  bool? hasWiki;
  bool? hasPages;
  bool? hasDownloads;
  bool? archived;
  bool? disabled;
  String? visibility;
  String? pushedAt;
  String? createdAt;
  String? updatedAt;
  Permissions? permissions;
  bool? allowRebaseMerge;
  String? templateRepository;
  String? tempCloneToken;
  bool? allowSquashMerge;
  bool? allowAutoMerge;
  bool? deleteBranchOnMerge;
  bool? allowMergeCommit;
  int? subscribersCount;
  int? networkCount;
  License? license;
  int? forks;
  int? openIssues;
  int? watchers;

  UserReposModel(
      {this.id,
      this.nodeId,
      this.name,
      this.fullName,
      this.owner,
      this.private,
      this.htmlUrl,
      this.description,
      this.fork,
      this.url,
      this.archiveUrl,
      this.assigneesUrl,
      this.blobsUrl,
      this.branchesUrl,
      this.collaboratorsUrl,
      this.commentsUrl,
      this.commitsUrl,
      this.compareUrl,
      this.contentsUrl,
      this.contributorsUrl,
      this.deploymentsUrl,
      this.downloadsUrl,
      this.eventsUrl,
      this.forksUrl,
      this.gitCommitsUrl,
      this.gitRefsUrl,
      this.gitTagsUrl,
      this.gitUrl,
      this.issueCommentUrl,
      this.issueEventsUrl,
      this.issuesUrl,
      this.keysUrl,
      this.labelsUrl,
      this.languagesUrl,
      this.mergesUrl,
      this.milestonesUrl,
      this.notificationsUrl,
      this.pullsUrl,
      this.releasesUrl,
      this.sshUrl,
      this.stargazersUrl,
      this.statusesUrl,
      this.subscribersUrl,
      this.subscriptionUrl,
      this.tagsUrl,
      this.teamsUrl,
      this.treesUrl,
      this.cloneUrl,
      this.mirrorUrl,
      this.hooksUrl,
      this.svnUrl,
      this.homepage,
      this.language,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.size,
      this.defaultBranch,
      this.openIssuesCount,
      this.isTemplate,
      this.topics,
      this.hasIssues,
      this.hasProjects,
      this.hasWiki,
      this.hasPages,
      this.hasDownloads,
      this.archived,
      this.disabled,
      this.visibility,
      this.pushedAt,
      this.createdAt,
      this.updatedAt,
      this.permissions,
      this.allowRebaseMerge,
      this.templateRepository,
      this.tempCloneToken,
      this.allowSquashMerge,
      this.allowAutoMerge,
      this.deleteBranchOnMerge,
      this.allowMergeCommit,
      this.subscribersCount,
      this.networkCount,
      this.license,
      this.forks,
      this.openIssues,
      this.watchers});

  UserReposModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nodeId = json['node_id'];
    name = json['name'];
    fullName = json['full_name'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    private = json['private'];
    htmlUrl = json['html_url'];
    description = json['description'];
    fork = json['fork'];
    url = json['url'];
    archiveUrl = json['archive_url'];
    assigneesUrl = json['assignees_url'];
    blobsUrl = json['blobs_url'];
    branchesUrl = json['branches_url'];
    collaboratorsUrl = json['collaborators_url'];
    commentsUrl = json['comments_url'];
    commitsUrl = json['commits_url'];
    compareUrl = json['compare_url'];
    contentsUrl = json['contents_url'];
    contributorsUrl = json['contributors_url'];
    deploymentsUrl = json['deployments_url'];
    downloadsUrl = json['downloads_url'];
    eventsUrl = json['events_url'];
    forksUrl = json['forks_url'];
    gitCommitsUrl = json['git_commits_url'];
    gitRefsUrl = json['git_refs_url'];
    gitTagsUrl = json['git_tags_url'];
    gitUrl = json['git_url'];
    issueCommentUrl = json['issue_comment_url'];
    issueEventsUrl = json['issue_events_url'];
    issuesUrl = json['issues_url'];
    keysUrl = json['keys_url'];
    labelsUrl = json['labels_url'];
    languagesUrl = json['languages_url'];
    mergesUrl = json['merges_url'];
    milestonesUrl = json['milestones_url'];
    notificationsUrl = json['notifications_url'];
    pullsUrl = json['pulls_url'];
    releasesUrl = json['releases_url'];
    sshUrl = json['ssh_url'];
    stargazersUrl = json['stargazers_url'];
    statusesUrl = json['statuses_url'];
    subscribersUrl = json['subscribers_url'];
    subscriptionUrl = json['subscription_url'];
    tagsUrl = json['tags_url'];
    teamsUrl = json['teams_url'];
    treesUrl = json['trees_url'];
    cloneUrl = json['clone_url'];
    mirrorUrl = json['mirror_url'];
    hooksUrl = json['hooks_url'];
    svnUrl = json['svn_url'];
    homepage = json['homepage'];
    language = json['language'];
    forksCount = json['forks_count'];
    stargazersCount = json['stargazers_count'];
    watchersCount = json['watchers_count'];
    size = json['size'];
    defaultBranch = json['default_branch'];
    openIssuesCount = json['open_issues_count'];
    isTemplate = json['is_template'];
    topics = json['topics'].cast<String>();
    hasIssues = json['has_issues'];
    hasProjects = json['has_projects'];
    hasWiki = json['has_wiki'];
    hasPages = json['has_pages'];
    hasDownloads = json['has_downloads'];
    archived = json['archived'];
    disabled = json['disabled'];
    visibility = json['visibility'];
    pushedAt = json['pushed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    permissions = json['permissions'] != null
        ? Permissions.fromJson(json['permissions'])
        : null;
    allowRebaseMerge = json['allow_rebase_merge'];
    templateRepository = json['template_repository'];
    tempCloneToken = json['temp_clone_token'];
    allowSquashMerge = json['allow_squash_merge'];
    allowAutoMerge = json['allow_auto_merge'];
    deleteBranchOnMerge = json['delete_branch_on_merge'];
    allowMergeCommit = json['allow_merge_commit'];
    subscribersCount = json['subscribers_count'];
    networkCount = json['network_count'];
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
    forks = json['forks'];
    openIssues = json['open_issues'];
    watchers = json['watchers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['node_id'] = nodeId;
    data['name'] = name;
    data['full_name'] = fullName;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['private'] = private;
    data['html_url'] = htmlUrl;
    data['description'] = description;
    data['fork'] = fork;
    data['url'] = url;
    data['archive_url'] = archiveUrl;
    data['assignees_url'] = assigneesUrl;
    data['blobs_url'] = blobsUrl;
    data['branches_url'] = branchesUrl;
    data['collaborators_url'] = collaboratorsUrl;
    data['comments_url'] = commentsUrl;
    data['commits_url'] = commitsUrl;
    data['compare_url'] = compareUrl;
    data['contents_url'] = contentsUrl;
    data['contributors_url'] = contributorsUrl;
    data['deployments_url'] = deploymentsUrl;
    data['downloads_url'] = downloadsUrl;
    data['events_url'] = eventsUrl;
    data['forks_url'] = forksUrl;
    data['git_commits_url'] = gitCommitsUrl;
    data['git_refs_url'] = gitRefsUrl;
    data['git_tags_url'] = gitTagsUrl;
    data['git_url'] = gitUrl;
    data['issue_comment_url'] = issueCommentUrl;
    data['issue_events_url'] = issueEventsUrl;
    data['issues_url'] = issuesUrl;
    data['keys_url'] = keysUrl;
    data['labels_url'] = labelsUrl;
    data['languages_url'] = languagesUrl;
    data['merges_url'] = mergesUrl;
    data['milestones_url'] = milestonesUrl;
    data['notifications_url'] = notificationsUrl;
    data['pulls_url'] = pullsUrl;
    data['releases_url'] = releasesUrl;
    data['ssh_url'] = sshUrl;
    data['stargazers_url'] = stargazersUrl;
    data['statuses_url'] = statusesUrl;
    data['subscribers_url'] = subscribersUrl;
    data['subscription_url'] = subscriptionUrl;
    data['tags_url'] = tagsUrl;
    data['teams_url'] = teamsUrl;
    data['trees_url'] = treesUrl;
    data['clone_url'] = cloneUrl;
    data['mirror_url'] = mirrorUrl;
    data['hooks_url'] = hooksUrl;
    data['svn_url'] = svnUrl;
    data['homepage'] = homepage;
    data['language'] = language;
    data['forks_count'] = forksCount;
    data['stargazers_count'] = stargazersCount;
    data['watchers_count'] = watchersCount;
    data['size'] = size;
    data['default_branch'] = defaultBranch;
    data['open_issues_count'] = openIssuesCount;
    data['is_template'] = isTemplate;
    data['topics'] = topics;
    data['has_issues'] = hasIssues;
    data['has_projects'] = hasProjects;
    data['has_wiki'] = hasWiki;
    data['has_pages'] = hasPages;
    data['has_downloads'] = hasDownloads;
    data['archived'] = archived;
    data['disabled'] = disabled;
    data['visibility'] = visibility;
    data['pushed_at'] = pushedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (permissions != null) {
      data['permissions'] = permissions!.toJson();
    }
    data['allow_rebase_merge'] = allowRebaseMerge;
    data['template_repository'] = templateRepository;
    data['temp_clone_token'] = tempCloneToken;
    data['allow_squash_merge'] = allowSquashMerge;
    data['allow_auto_merge'] = allowAutoMerge;
    data['delete_branch_on_merge'] = deleteBranchOnMerge;
    data['allow_merge_commit'] = allowMergeCommit;
    data['subscribers_count'] = subscribersCount;
    data['network_count'] = networkCount;
    if (license != null) {
      data['license'] = license!.toJson();
    }
    data['forks'] = forks;
    data['open_issues'] = openIssues;
    data['watchers'] = watchers;
    return data;
  }
}

class Owner {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;

  Owner(
      {this.login,
      this.id,
      this.nodeId,
      this.avatarUrl,
      this.gravatarId,
      this.url,
      this.htmlUrl,
      this.followersUrl,
      this.followingUrl,
      this.gistsUrl,
      this.starredUrl,
      this.subscriptionsUrl,
      this.organizationsUrl,
      this.reposUrl,
      this.eventsUrl,
      this.receivedEventsUrl,
      this.type,
      this.siteAdmin});

  Owner.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    gistsUrl = json['gists_url'];
    starredUrl = json['starred_url'];
    subscriptionsUrl = json['subscriptions_url'];
    organizationsUrl = json['organizations_url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    receivedEventsUrl = json['received_events_url'];
    type = json['type'];
    siteAdmin = json['site_admin'];
  }

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
    return data;
  }
}

class Permissions {
  bool? admin;
  bool? push;
  bool? pull;

  Permissions({this.admin, this.push, this.pull});

  Permissions.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    push = json['push'];
    pull = json['pull'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['push'] = push;
    data['pull'] = pull;
    return data;
  }
}

class License {
  String? key;
  String? name;
  String? url;
  String? spdxId;
  String? nodeId;
  String? htmlUrl;

  License(
      {this.key, this.name, this.url, this.spdxId, this.nodeId, this.htmlUrl});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    url = json['url'];
    spdxId = json['spdx_id'];
    nodeId = json['node_id'];
    htmlUrl = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['url'] = url;
    data['spdx_id'] = spdxId;
    data['node_id'] = nodeId;
    data['html_url'] = htmlUrl;
    return data;
  }
}
