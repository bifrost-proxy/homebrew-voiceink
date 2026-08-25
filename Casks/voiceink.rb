cask "voiceink" do
  arch arm: "arm64", intel: "x86_64"

  version "2.3.1"
  sha256 arm:   "46f94baa85f8c4eef0b2daf5cd7aea216c1b1651120cdeb45d8dbc5303f28d5e",
         intel: "7eed42d2d5283ad8b395ee68da00604be40d91eaff7051762fdd080d6be4a50a"

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
