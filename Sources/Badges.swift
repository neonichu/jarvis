import PathKit

extension Path {
  func childrenMatching(string: String) throws -> [Path] {
    return try self.children().filter { String($0).rangeOfString(string) != nil }
  }
}

public struct Badges {
  private static func generateCocoaPodsBadges() throws {
    if let podspec = try Path.current.childrenMatching(".podspec").first {
      let name = podspec.lastComponentWithoutExtension
      for path in ["l": "License", "p": "Platform", "v": "Version"] {
        print("[![\(path.1)](https://img.shields.io/cocoapods/\(path.0)/\(name).svg?style=flat)](http://cocoadocs.org/docsets/\(name))")
      }
    } 
  }

  private static func generateCoverallBadges() throws {
    try generateGitHubBadges(".slather.yml") {
      let repo = "\($0.0)/\($0.1)"
      print("[![Coverage Status](https://img.shields.io/coveralls/\(repo).svg)](https://coveralls.io/github/\(repo))")
    }
  }

  private static func generateGitHubBadges(matching: String, action: (gh: (String, String)) -> ()) throws {
    if let _ = try Path.current.childrenMatching(matching).first, gh = github_data_from_git() {
      action(gh: gh)
    }
  }

  private static func generateTravisBadges() throws {
    try generateGitHubBadges(".travis.yml") { gh in
      let repo = "\(gh.0)/\(gh.1)"
      print("[![Build Status](https://img.shields.io/travis/\(repo)/master.svg?style=flat)](https://travis-ci.org/\(repo))")
    }
  }

  public static func generate() throws {
    try generateCocoaPodsBadges()
    try generateTravisBadges()
    try generateCoverallBadges()
  }
}
