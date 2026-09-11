cask "mu-editor" do
  version "1.2.0"
  sha256 "306bef4ebfafd1dcf928bc260d5d57e64efbccb537b27f5818a9fc12437726b6"

  url "https://github.com/mu-editor/mu/releases/download/v#{version}/MuEditor-osx-#{version}.dmg"
  name "Mu"
  desc "Small, simple editor for beginner Python programmers"
  homepage "https://codewith.mu/"


  depends_on :macos

  app "Mu Editor.app"

  postflight_steps do
    run "echo", args: ["Releasing #{token} from quarantine"], print_stdout: true
    run "/usr/bin/xattr", base: :appdir, args: [
      "-dr",
      "com.apple.quarantine",
      "{{appdir}}/Mu Editor.app",
    ]
  end

  zap trash: [
        "~/Library/Application Support/mu",
        "~/Library/Logs/mu",
      ],
      rmdir: "~/mu_code"

  caveats do
    requires_rosetta
  end
end
