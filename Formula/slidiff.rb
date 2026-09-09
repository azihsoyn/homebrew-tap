class Slidiff < Formula
  desc "A slide deck an agent writes and a person reads in the terminal — slides point at file:line, the viewer draws the real diff, and review progress travels back"
  homepage "https://github.com/azihsoyn/slidiff"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.3/slidiff-aarch64-apple-darwin.tar.xz"
      sha256 "dfc1a8007811f8daf350318cdd328ce3572656cd6c0b147931b1c8cda894d778"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.3/slidiff-x86_64-apple-darwin.tar.xz"
      sha256 "051988283a140f0d129dc6e27fb3c0c50cdbb1ac4edc1db376eca3c3fb0eacb2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.3/slidiff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "55e40a8c0d2fbff603b308d80535e39a91125f9f57c7a837b1b4b50aaa018629"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.3/slidiff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb02659e425eeb029f8d1ed780130629b266134ddd1cc1f187938cf37a7cec58"
    end
  end
  license "MIT"

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
      bin.install "slidiff"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "slidiff"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "slidiff"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "slidiff"
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
