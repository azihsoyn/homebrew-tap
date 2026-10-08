class Laugh < Formula
  desc "Review a GitHub pull request without leaving the terminal: every review thread including resolved ones, Viewed state for the changed files, CI failures with their logs, and a reading order"
  homepage "https://github.com/azihsoyn/laugh"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/laugh/releases/download/v0.2.0/laugh-aarch64-apple-darwin.tar.xz"
      sha256 "13ea6924db0859f803adc8e0f7999427246944fb298c2d532c1828ef51266311"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/laugh/releases/download/v0.2.0/laugh-x86_64-apple-darwin.tar.xz"
      sha256 "460d22ac3d3a3cfe70c12ebbf93c7c61138a0b42ca318533d73e970900a7b6a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/laugh/releases/download/v0.2.0/laugh-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7153edd4e86d72ec4052679c83c3e3525e9e31ebf2cc649bad1bb85606ac4c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/laugh/releases/download/v0.2.0/laugh-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ad23dbe3bdf16287c80904e5ece14e16825914b8aef1133844bb5d56a144f45e"
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
      bin.install "laugh"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "laugh"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "laugh"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "laugh"
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
