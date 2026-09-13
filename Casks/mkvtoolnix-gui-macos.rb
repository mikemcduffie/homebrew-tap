cask "mkvtoolnix-gui-macos" do
  arch arm: "arm64", intel: "x86_64"

  version "v101.0-b2026.08.1"
  sha256 arm:   "sha256:e5e621ce8934ab1e372c743fe62bdf80d4efcadbd6da6c8a1d05c1606ee83fe8",
         intel: "sha256:8d3ac752335186f2572c8ba400c26664fcd407d4a16d933a834a3ee2415d5fff"

  url "https://github.com/CorticalCode/mkvtoolnix-gui-macos/releases/download/#{version}/MKVToolNix-/#{version.split("-").first}-macos-apple-#{arch}.dmg"
  name "MKVToolNix"
  desc "Set of tools to create, alter and inspect Matroska files (MKV)"
  homepage "https://mkvtoolnix.download/"

   livecheck do
    url :url
    strategy :github_latest
  end
  
  depends_on macos: :ventura

  appname "MKVToolNix-#{version.split("-").first}.app"
  app "#{appname}"
  binary "#{appdir}/#{appname}/Contents/MacOS/mkvextract"
  binary "#{appdir}/#{appname}/Contents/MacOS/mkvinfo"
  binary "#{appdir}/#{appname}/Contents/MacOS/mkvmerge"
  binary "#{appdir}/#{appname}/Contents/MacOS/mkvpropedit"
  manpage "#{appdir}/#{appname}/Contents/MacOS/man/man1/mkvextract.1"
  manpage "#{appdir}/#{appname}/Contents/MacOS/man/man1/mkvinfo.1"
  manpage "#{appdir}/#{appname}/Contents/MacOS/man/man1/mkvmerge.1"
  manpage "#{appdir}/#{appname}/Contents/MacOS/man/man1/mkvpropedit.1"
  manpage "#{appdir}/#{appname}/Contents/MacOS/man/man1/mkvtoolnix-gui.1"

  postflight_steps do
    run "echo", args: ["Removing #{token} from quarantine"], print_stdout: true
    run "/usr/bin/xattr", base: :appdir, args: [
      "-dr",
      "com.apple.quarantine",
      "{{appdir}}/{{appname}}.app",
    ]
  end

  zap trash: [
    "~/Library/Preferences/bunkus.org/mkvtoolnix-gui",
    "~/Library/Saved Application State/download.mkvtoolnix.MKVToolNix.savedState",
  ]
end
