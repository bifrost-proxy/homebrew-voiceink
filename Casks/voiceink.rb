cask "voiceink" do
  arch arm: "arm64", intel: "x86_64"

  version "2.2.69"
  sha256 arm:   "dff5dbf7f1dab6ff4abd035820b339a77c74776e53c94805332cd30bbc386222",
         intel: "89a83c803008798c6b3bcdf4e24f832bafddfc5ce0439be9c1c8fbfcf175dbab"

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
