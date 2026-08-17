cask "voiceink" do
  version "2.2.28"
  sha256 "569432e7f812f0f55e19752cd2596144c75013836c56fc2e6ab0d71b8dc16bd9"

  url "https://github.com/bifrost-proxy/VoiceInk/releases/download/v#{version}/VoiceInk.zip"
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
