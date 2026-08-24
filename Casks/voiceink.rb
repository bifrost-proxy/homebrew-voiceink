cask "voiceink" do
  arch arm: "arm64", intel: "x86_64"

  version "2.2.81"
  sha256 arm:   "cb48e37a301966dea82fafb35cb9fd3e5c84ee0a56b7fdb9adb3cbffbe9470b6",
         intel: "3fddd0b0e6e65d84a07b67559d8f0d83848bc57ece2e9575014ba53f0cc2d562"

  url "https://github.com/bifrost-proxy/VoiceInk/releases/download/v#{version}/VoiceInk-#{arch}.zip"
  name "VoiceInk"
  desc "Privacy-focused voice-to-text app"
  homepage "https://github.com/bifrost-proxy/VoiceInk"

  depends_on macos: :sonoma

  app "VoiceInk.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/VoiceInk.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.prakashjoshipax.VoiceInk",
    "~/Library/Caches/com.prakashjoshipax.VoiceInk",
    "~/Library/Preferences/com.prakashjoshipax.VoiceInk.plist",
  ]

  caveats <<~EOS
    VoiceInk community releases use an ad-hoc signature because they are
    published without an Apple Developer ID certificate. After verifying the
    release SHA-256, this cask removes the quarantine attribute so macOS can
    open the app.
  EOS
end
