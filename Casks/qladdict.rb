cask "qladdict" do
  version "1.3.0"
  sha256 "9342a65b103ab4f71b21f4094f0f9ad8c48b38e976fc4d10cf2995936531e551"

  url "https://github.com/tattali/QLAddict/releases/download/#{version}/QLAddict.qlgenerator.#{version}.zip"
  name "QLAddict"
  desc "Quick Look plugin for subtitle (.srt) files"
  homepage "https://github.com/tattali/QLAddict/"


  depends_on :macos

  qlplugin "QLAddict.qlgenerator"

  postflight_steps do
    run "echo", args: ["Removing #{token} from quarantine"], print_stdout: true
    run "pwd", base: :qlplugindir, print_stdout: true
    run "/usr/bin/xattr", base: :qlplugindir, sudo: true, args: [
      "-dr",
      "com.apple.quarantine",
      "QLAddict.qlgenerator",
    ]
    run "echo", args: ["Restarting quicklook service"], print_stdout: true
    run "/usr/bin/qlmanage", args: ["-r"]
  end

  # No zap stanza required
end
