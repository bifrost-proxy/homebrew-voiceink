cask "voiceink" do
  arch arm: "arm64", intel: "x86_64"

  version "2.2.70"
  sha256 arm:   "e57f123d50978024dbce9ccc5f14548baa8a43e9c94afd8acf1285701353272c",
         intel: "cffe6077bb93fb17bba0fef2a88c2c9977732a12792a1431456ecaf61ad2445a"

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
