# Homebrew cask for macOS (the .dmg) and Linux (the AppImage, which carries its own
# libmpv). The release workflow fills in `version` and each file's `sha256`
# (packaging/update_manifests.sh) and pushes the result to the tap's Casks/ folder:
#   brew install --cask araryarch67/riflay/riflay
# A release without the macOS build (a failed macOS job) leaves the macOS sha256
# unchecked, and its URL has nothing to fetch.
cask "riflay" do
  version "1.2.2"

  on_macos do
    sha256 "f4a79bf69db6d32e800bd6fb6a7e6dc6b732773f6d3601cef34824b461528372" # Riflay-macos.dmg

    url "https://github.com/Araryarch67/Riflay/releases/download/v#{version}/Riflay-macos.dmg"

    depends_on macos: ">= :monterey"

    app "Riflay.app"

    # Signed ad hoc, not notarized (no Apple Developer ID): without this, Gatekeeper
    # says the app "is damaged" on first start.
    postflight do
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", "#{appdir}/Riflay.app"]
    end

    zap trash: [
      "~/Library/Application Support/dev.riflay.riflay",
      "~/Library/Caches/dev.riflay.riflay",
      "~/Library/HTTPStorages/dev.riflay.riflay",
      "~/Library/Preferences/dev.riflay.riflay.plist",
      "~/Library/Saved Application State/dev.riflay.riflay.savedState",
      "~/Library/WebKit/dev.riflay.riflay",
    ]
  end
  on_linux do
    sha256 "bb43cdab67dd4ae1b129b70daa4076eb5651b8d12fd6c779d732361c1a1012e0" # Riflay-linux-x86_64.AppImage

    url "https://github.com/Araryarch67/Riflay/releases/download/v#{version}/Riflay-linux-x86_64.AppImage"

    depends_on arch: :x86_64

    app_image "Riflay-linux-x86_64.AppImage"

    zap trash: "~/.local/share/dev.riflay.riflay"
  end

  name "Riflay"
  desc "Music player for your own music and YouTube Music, with hi-fi audio"
  homepage "https://github.com/Araryarch67/Riflay"

  livecheck do
    url :url
    strategy :github_latest
  end
end
