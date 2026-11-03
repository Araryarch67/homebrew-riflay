# Homebrew tap for Riflay

[Riflay](https://github.com/Araryarch67/Riflay) is a music player for your own music and YouTube Music, with hi-fi audio.

```sh
brew install --cask araryarch67/riflay/riflay
```

On macOS it installs Riflay.app; on Linux (x86_64) it installs the AppImage and adds
Riflay to the application menu. The AppImage needs FUSE 2 (`libfuse2` on Debian /
Ubuntu, `fuse2` on Arch, `fuse-libs` on Fedora).

`Casks/riflay.rb` is updated by Riflay's release workflow; change it in the Riflay
repository (`packaging/homebrew/Casks/riflay.rb`), not here.
