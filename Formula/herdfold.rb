class Herdfold < Formula
  desc "Long text, laid out as facing pages you turn: a book reader across two herdr panes, with bookmarks, notes and an agent to ask"
  homepage "https://github.com/azihsoyn/herdfold"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.3.0/herdfold-aarch64-apple-darwin.tar.xz"
      sha256 "cf8b0aa04867d0d320ad9415740e10f7369107fcc2bcdfd5fed7e3c10a8e3fc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.3.0/herdfold-x86_64-apple-darwin.tar.xz"
      sha256 "d46e53104db1ca18d1830bf618327fc90da8ec252234a53b58e743d4abc9a669"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.3.0/herdfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fefe2ccd73cc40c82ca53e17c8b2a37f7e930e3614a03748ea2336fe681e4d81"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.3.0/herdfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ed5d36d24346928bf5657cbd1e9c1b23cc1b4ac0147595260ec8daf1f6b9651"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "herdfold"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "herdfold"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "herdfold"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "herdfold"
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
