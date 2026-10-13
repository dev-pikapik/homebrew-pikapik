cask "pikapik" do
  version "1.39.2"
  sha256 "44c9b44fc0b3b87dcb300d090f7b3d3efaf0adbc029d2d07d6ed1fe94ce30df1"

  url "https://github.com/dev-pikapik/pikapik/releases/download/v#{version}/pikapik.zip"
  name "pikapik"
  desc "Menu bar tools for keys, windows and the Dock, plus Keep Awake"
  homepage "https://github.com/dev-pikapik/pikapik"

  auto_updates true
  depends_on macos: :sonoma

  app "pikapik.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/pikapik.app"], must_succeed: false
    remove "{{appdir}}/pikapik.app", recursive: true
  end

  uninstall_preflight_steps do
    run "{{appdir}}/pikapik.app/Contents/MacOS/pikapik", args: ["--uninstall"], must_succeed: false
  end

  uninstall_postflight_steps do
    remove "{{appdir}}/pikapik.app", recursive: true
  end

  uninstall quit: "com.pikapik.app.direct"

  zap launchctl: "com.pikapik.app.direct.fans",
      delete:    [
        "/Library/LaunchDaemons/com.pikapik.app.direct.fans.plist",
        "/Library/PrivilegedHelperTools/com.pikapik.app.direct.fans",
      ],
      trash:     [
    "~/Library/Application Scripts/com.pikapik.app.direct.archive",
    "~/Library/Application Scripts/com.pikapik.app.direct.compress",
    "~/Library/Application Scripts/com.pikapik.app.direct.convert",
    "~/Library/Application Scripts/com.pikapik.app.direct.new-file",
    "~/Library/Application Scripts/com.pikapik.app.direct.preview",
    "~/Library/Application Support/pikapik",
    "~/Library/Caches/com.pikapik.app.direct",
    "~/Library/Containers/com.pikapik.app.direct.archive",
    "~/Library/Containers/com.pikapik.app.direct.compress",
    "~/Library/Containers/com.pikapik.app.direct.convert",
    "~/Library/Containers/com.pikapik.app.direct.new-file",
    "~/Library/Containers/com.pikapik.app.direct.preview",
    "~/Library/HTTPStorages/com.pikapik.app.direct",
    "~/Library/Preferences/com.pikapik.app.direct.plist",
  ]

  caveats <<~EOS
    pikapik needs two permissions in System Settings › Privacy & Security:
      Accessibility and Input Monitoring
    The app opens a window that walks you through them.
  EOS
end
