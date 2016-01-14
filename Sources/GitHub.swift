import Chores
import Foundation

// FIXME: C&P from Chocolat

extension String {
  func components(separator: Character = "\n") -> [String] {
    return self.characters.split(separator).map(String.init)
  }

  var lines: [String] {
    return components("\n")
  }
}

func github_data_from_remote(remote: String) -> (String, String)? {
  if remote.rangeOfString("git@github.com") != nil {
    if let meat = remote.components(":").last?.components(".").first?.components("/") {
      return (meat[0], meat[1])
    }
  } else {
    if let url = NSURL(string: remote), components = url.pathComponents {
      return (components[components.count-2], components[components.count-1])
    }
  }

  return nil
}

func github_data_from_git() -> (String, String)? {
  if let remote = (>["git", "remote", "-v"]).stdout.lines.first,
      data = github_data_from_remote(remote) {
    return data
  }

  return nil
}
