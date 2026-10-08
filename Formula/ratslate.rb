class Ratslate < Formula
  desc "An infinite canvas in the terminal: boxes, arrows and text, placed with the mouse, written out as ASCII"
  homepage "https://github.com/azihsoyn/ratslate"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.3.0/ratslate-aarch64-apple-darwin.tar.xz"
      sha256 "f351f6b894f2c3c87a400fee7280b3758d0e30a8fde0650b925266060f448e0f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.3.0/ratslate-x86_64-apple-darwin.tar.xz"
      sha256 "705739174295222b59697a174e796015e4de8605c77fcae5ae1cab7c225dd8a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.3.0/ratslate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fdc2ada714a0f9fa108809d19a657c8f78f0b19f13ba61441c37f6488226f225"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.3.0/ratslate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4f99e11bc2ea12fc6ffb510afc486a1c04b3fee935917f58af283efe5eb80778"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ratslate"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ratslate"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ratslate"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ratslate"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
