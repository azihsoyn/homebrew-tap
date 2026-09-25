class Ratslate < Formula
  desc "An infinite canvas in the terminal: boxes, arrows and text, placed with the mouse, written out as ASCII"
  homepage "https://github.com/azihsoyn/ratslate"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.2.0/ratslate-aarch64-apple-darwin.tar.xz"
      sha256 "bbfe61fd59452a10c2b2247539dc8e50a14677a0da8610670bc870815a781803"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.2.0/ratslate-x86_64-apple-darwin.tar.xz"
      sha256 "0b05a88b12d5571df0e1a7f2e306b5386c2ed640fff48c03d2e2a30a5c26e766"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.2.0/ratslate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3273849356f26a0edba118ed4f0f97e707d2debc3abf4e900cc9ce1c67ebfb1c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.2.0/ratslate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d0c3b4271756f007fe984d4950723e06112844605e352a395b5c688e1ba7953f"
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
