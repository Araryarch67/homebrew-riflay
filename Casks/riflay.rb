# Homebrew cask for macOS (the .dmg) and Linux (the AppImage, which carries its own
# libmpv). The release workflow fills in `version` and each file's `sha256`
# (packaging/update_manifests.sh) and pushes the result to the tap's Casks/ folder:
#   brew install --cask araryarch67/riflay/riflay
# A release without the macOS build (a failed macOS job) leaves the macOS sha256
# unchecked, and its URL has nothing to fetch.
cask "riflay" do
  version "1.3.1"

  on_macos do
    sha256 "ff5212b03b3bd437c7f79a8ccb0e6f7393bfc2268f4e170b39a4fab697a7af39" # Riflay-macos.dmg

    url "https://github.com/Araryarch67/Riflay/releases/download/v#{version}/Riflay-macos.dmg"

    depends_on macos: ">= :monterey"

    app "Riflay.app"
    binary "#{appdir}/Riflay.app/Contents/MacOS/riflay-cli"

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
    sha256 "400940d0d9de1063254bfb5df2da0fd838e09bd4bb68723b0543e2a82bfb270e" # Riflay-linux-x86_64.AppImage

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
