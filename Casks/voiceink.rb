cask "voiceink" do
  arch arm: "arm64", intel: "x86_64"

  version "2.3.2"
  sha256 arm:   "1fcaa9b9f447f46a537386e381918cf6003fa3a991d45619ca7e4fb3f5c78e2b",
         intel: "88f7490226eef0dbde671c5cd2525cef00d19ed8d04081659443673da77fdac1"

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
