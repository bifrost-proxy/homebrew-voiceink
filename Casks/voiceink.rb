cask "voiceink" do
  version "2.2.33"
  sha256 "c16b23d3593f83ca1c6377f7588dbf4a0f93e13559112187e4d9d70a3598f6e5"

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
