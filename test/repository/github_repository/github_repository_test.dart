import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mockito/mockito.dart';

import 'package:github_user/repository/model/logged_user_model.dart';
import 'package:github_user/repository/model/token_model.dart';
import 'package:github_user/repository/model/user_repos_model.dart';
import 'package:github_user/repository/rest_client/irest_client.dart';
import 'package:github_user/repository/rest_client/irest_response.dart';
import 'package:github_user/repository/rest_client/rest_client.dart';
import 'package:github_user/repository/rest_client/rest_client_exception.dart';
import 'package:github_user/repository/rest_client/rest_response.dart';
import 'package:github_user/repository/token_repository/token_respository.dart';
import 'package:github_user/repository/gihub_repository/igithub_repository.dart';
import 'package:github_user/repository/model/user_model.dart';

import 'package:github_user/repository/gihub_repository/gitgub_repository.dart';

class MockUserRepository extends Mock implements IGithubRepository {}

class MockRestResponse extends Mock implements IRestResponse {}

class MockTokenResponse extends Mock implements ITokenReposytory {
  @override
  Future<TokenModel?> get() async {
    return null;
  }
}

class MockRestClient404 extends Mock implements IRestClient {
  @override
  Future<RestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization}) async {
    return restResponse404;
  }
}

class MockRestClient200 extends Mock implements IRestClient {
  @override
  Future<RestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization}) async {
    return restResponse200;
  }
}

class MockRestClient extends Mock implements IRestClient {}

class MockGithubAPIMock extends Mock implements IGithubRepository {
  final RestClient _restClient = RestClient();
  @override
  Future<List<UserReposModel?>> repos() async {
    var resp = await RestClient().sendGet(
      url: "https://api.github.com/users/octocat/repos",
    );

    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");
    List<dynamic> list = jsonDecode(resp.content);
    return list.map((e) => UserReposModel.fromJson(e)).toList();
  }
}

class MockRestClientresp extends Mock implements IRestClient {
  @override
  Future<RestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization}) async {
    return restResponse200;
  }
}

// @GenerateMocks([
//   IRestClient,
// ])
main() async {
  late IRestClient restClient;
  late ITokenReposytory tokenReposytory;

  group("API mock github", () {
    setUp(() {
      restClient = MockRestClient();
      tokenReposytory = MockTokenResponse();
    });
    test('Repos test model', () async {
      // final resultMockAPI = await RestClient()
      //     .sendGet(url: "https://api.github.com/users/octocat/repos");

      // when(() => restClient.sendGet(url: ""))
      //     .thenAnswer((_) async => (resultMockAPI));

      var result = await MockGithubAPIMock().repos();

      expect(result.runtimeType, List<UserReposModel>);
    });
  });
  group('not found test exception', () {
    setUp(() {
      restClient = MockRestClient404();
      tokenReposytory = MockTokenResponse();
    });

    test("User not found", () async {
      var userRepositoryTestError =
          GithubRepository(restClient, tokenReposytory);

      expect(() async => await userRepositoryTestError.getUser("Fernan----"),
          throwsA(isA<RestClientException>()));
    });
  });

  group('Success', () {
    setUp(() {
      restClient = MockRestClient200();

      tokenReposytory = MockTokenResponse();
    });

    test("Success", () async {
      var userRepositoryTestError =
          GithubRepository(restClient, tokenReposytory);
      final result = await userRepositoryTestError.getUser("Fernando");

      expect(result.runtimeType, LoggedUserModel());
      expect(result?.name, resultGet200.name);
      expect(result?.bio, resultGet200.bio);
      expect(result?.blog, resultGet200.blog);
      expect(result?.nodeId, resultGet200.nodeId);
      expect(result?.email, resultGet200.email);
      expect(result?.createdAt, resultGet200.createdAt);
      expect(result?.followers, resultGet200.followers);
      expect(result?.followersUrl, resultGet200.followersUrl);
      expect(result?.following, resultGet200.following);
      expect(result?.followingUrl, resultGet200.followingUrl);
    });
  });
}

final restResponse404 = RestResponse(
    content: jsonEncode({
      "message": "Not Found",
      "documentation_url":
          "https://docs.github.com/rest/users/users#get-a-user",
      "status": "404"
    }),
    contentBytes: Uint8List.fromList([]),
    statusCode: 404,
    url: 'https://api.github.com/users/Fernnn---');

final restResponse200 = RestResponse(
    content: """{"login": "fernando",
      "id": 36909007,
      "node_id": "MDQ6VXNlcjM2OTA5MDA3",
      "avatar_url": "https://avatars.githubusercontent.com/u/36909007?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/fernando",
      "html_url": "https://github.com/fernando",
      "followers_url": "https://api.github.com/users/fernando/followers",
      "following_url":
          "https://api.github.com/users/fernando/following{/other_user}",
      "gists_url": "https://api.github.com/users/fernando/gists{/gist_id}",
      "starred_url":
          "https://api.github.com/users/fernando/starred{/owner}{/repo}",
      "subscriptions_url":
          "https://api.github.com/users/fernando/subscriptions",
      "organizations_url": "https://api.github.com/users/fernando/orgs",
      "repos_url": "https://api.github.com/users/fernando/repos",
      "events_url": "https://api.github.com/users/fernando/events{/privacy}",
      "received_events_url":
          "https://api.github.com/users/fernando/received_events",
      "type": "User",
      "site_admin": false,
      "name": "Fernando",
      "company": null,
      "blog": "",
      "location": null,
      "email": null,
      "hireable": null,
      "bio": null,
      "twitter_username": null,
      "public_repos": 4,
      "public_gists": 1,
      "followers": 2,
      "following": 0,
      "created_at": "2018-02-28T03:42:13Z",
      "updated_at": "2024-05-25T18:42:28Z"
    }""",
    contentBytes: Uint8List.fromList([
      123,
      34,
      108,
      111,
      103,
      105,
      110,
      34,
      58,
      34,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      34,
      44,
      34,
      105,
      100,
      34,
      58,
      51,
      54,
      57,
      48,
      57,
      48,
      48,
      55,
      44,
      34,
      110,
      111,
      100,
      101,
      95,
      105,
      100,
      34,
      58,
      34,
      77,
      68,
      81,
      54,
      86,
      88,
      78,
      108,
      99,
      106,
      77,
      50,
      79,
      84,
      65,
      53,
      77,
      68,
      65,
      51,
      34,
      44,
      34,
      97,
      118,
      97,
      116,
      97,
      114,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      118,
      97,
      116,
      97,
      114,
      115,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      117,
      115,
      101,
      114,
      99,
      111,
      110,
      116,
      101,
      110,
      116,
      46,
      99,
      111,
      109,
      47,
      117,
      47,
      51,
      54,
      57,
      48,
      57,
      48,
      48,
      55,
      63,
      118,
      61,
      52,
      34,
      44,
      34,
      103,
      114,
      97,
      118,
      97,
      116,
      97,
      114,
      95,
      105,
      100,
      34,
      58,
      34,
      34,
      44,
      34,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      34,
      44,
      34,
      104,
      116,
      109,
      108,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      34,
      44,
      34,
      102,
      111,
      108,
      108,
      111,
      119,
      101,
      114,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      102,
      111,
      108,
      108,
      111,
      119,
      101,
      114,
      115,
      34,
      44,
      34,
      102,
      111,
      108,
      108,
      111,
      119,
      105,
      110,
      103,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      102,
      111,
      108,
      108,
      111,
      119,
      105,
      110,
      103,
      123,
      47,
      111,
      116,
      104,
      101,
      114,
      95,
      117,
      115,
      101,
      114,
      125,
      34,
      44,
      34,
      103,
      105,
      115,
      116,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      103,
      105,
      115,
      116,
      115,
      123,
      47,
      103,
      105,
      115,
      116,
      95,
      105,
      100,
      125,
      34,
      44,
      34,
      115,
      116,
      97,
      114,
      114,
      101,
      100,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      115,
      116,
      97,
      114,
      114,
      101,
      100,
      123,
      47,
      111,
      119,
      110,
      101,
      114,
      125,
      123,
      47,
      114,
      101,
      112,
      111,
      125,
      34,
      44,
      34,
      115,
      117,
      98,
      115,
      99,
      114,
      105,
      112,
      116,
      105,
      111,
      110,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      115,
      117,
      98,
      115,
      99,
      114,
      105,
      112,
      116,
      105,
      111,
      110,
      115,
      34,
      44,
      34,
      111,
      114,
      103,
      97,
      110,
      105,
      122,
      97,
      116,
      105,
      111,
      110,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      111,
      114,
      103,
      115,
      34,
      44,
      34,
      114,
      101,
      112,
      111,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      114,
      101,
      112,
      111,
      115,
      34,
      44,
      34,
      101,
      118,
      101,
      110,
      116,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      101,
      118,
      101,
      110,
      116,
      115,
      123,
      47,
      112,
      114,
      105,
      118,
      97,
      99,
      121,
      125,
      34,
      44,
      34,
      114,
      101,
      99,
      101,
      105,
      118,
      101,
      100,
      95,
      101,
      118,
      101,
      110,
      116,
      115,
      95,
      117,
      114,
      108,
      34,
      58,
      34,
      104,
      116,
      116,
      112,
      115,
      58,
      47,
      47,
      97,
      112,
      105,
      46,
      103,
      105,
      116,
      104,
      117,
      98,
      46,
      99,
      111,
      109,
      47,
      117,
      115,
      101,
      114,
      115,
      47,
      102,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      47,
      114,
      101,
      99,
      101,
      105,
      118,
      101,
      100,
      95,
      101,
      118,
      101,
      110,
      116,
      115,
      34,
      44,
      34,
      116,
      121,
      112,
      101,
      34,
      58,
      34,
      85,
      115,
      101,
      114,
      34,
      44,
      34,
      115,
      105,
      116,
      101,
      95,
      97,
      100,
      109,
      105,
      110,
      34,
      58,
      102,
      97,
      108,
      115,
      101,
      44,
      34,
      110,
      97,
      109,
      101,
      34,
      58,
      34,
      70,
      101,
      114,
      110,
      97,
      110,
      100,
      111,
      34,
      44,
      34,
      99,
      111,
      109,
      112,
      97,
      110,
      121,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      98,
      108,
      111,
      103,
      34,
      58,
      34,
      34,
      44,
      34,
      108,
      111,
      99,
      97,
      116,
      105,
      111,
      110,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      101,
      109,
      97,
      105,
      108,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      104,
      105,
      114,
      101,
      97,
      98,
      108,
      101,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      98,
      105,
      111,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      116,
      119,
      105,
      116,
      116,
      101,
      114,
      95,
      117,
      115,
      101,
      114,
      110,
      97,
      109,
      101,
      34,
      58,
      110,
      117,
      108,
      108,
      44,
      34,
      112,
      117,
      98,
      108,
      105,
      99,
      95,
      114,
      101,
      112,
      111,
      115,
      34,
      58,
      52,
      44,
      34,
      112,
      117,
      98,
      108,
      105,
      99,
      95,
      103,
      105,
      115,
      116,
      115,
      34,
      58,
      49,
      44,
      34,
      102,
      111,
      108,
      108,
      111,
      119,
      101,
      114,
      115,
      34,
      58,
      50,
      44,
      34,
      102,
      111,
      108,
      108,
      111,
      119,
      105,
      110,
      103,
      34,
      58,
      48,
      44,
      34,
      99,
      114,
      101,
      97,
      116,
      101,
      100,
      95,
      97,
      116,
      34,
      58,
      34,
      50,
      48,
      49,
      56,
      45,
      48,
      50,
      45,
      50,
      56,
      84,
      48,
      51,
      58,
      52,
      50,
      58,
      49,
      51,
      90,
      34,
      44,
      34,
      117,
      112,
      100,
      97,
      116,
      101,
      100,
      95,
      97,
      116,
      34,
      58,
      34,
      50,
      48,
      50,
      52,
      45,
      48,
      53,
      45,
      50,
      53,
      84,
      49,
      56,
      58,
      52,
      50,
      58,
      50,
      56,
      90,
      34,
      125
    ]),
    statusCode: 200,
    url: 'https://api.github.com/users/Fernando');

final resultGet200 = UserModel(
  avatarUrl: "https://avatars.githubusercontent.com/u/36909007?v=4",
  bio: "",
  blog: "",
  company: "",
  createdAt: "2018-02-28T03:42:13Z",
  email: "",
  eventsUrl: "https://api.github.com/users/fernando/events{/privacy}",
  followers: 2,
  followersUrl: "https://api.github.com/users/fernando/followers",
  following: 0,
  followingUrl: "https://api.github.com/users/fernando/following{/other_user}",
  gistsUrl: "https://api.github.com/users/fernando/gists{/gist_id}",
  gravatarId: "",
  hireable: null,
  htmlUrl: "https://github.com/fernando",
  id: 36909007,
  location: "",
  login: "fernando",
  name: "Fernando",
  nodeId: "MDQ6VXNlcjM2OTA5MDA3",
  organizationsUrl: "https://api.github.com/users/fernando/orgs",
  publicGists: 1,
  publicRepos: 4,
  siteAdmin: false,
  starredUrl: "https://api.github.com/users/fernando/starred{/owner}{/repo}",
  subscriptionsUrl: "https://api.github.com/users/fernando/subscriptions",
  twitterUsername: "",
  type: "User",
  updatedAt: "2024-05-25T18:42:28Z",
  url: "https://api.github.com/users/fernando",
  reposUrl: "https://api.github.com/users/fernando/repos",
  receivedEventsUrl: "https://api.github.com/users/fernando/received_events",
);
