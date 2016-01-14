import Commander

Group {
  $0.command("badges") {
  	try Badges.generate()
  }
}.run()
