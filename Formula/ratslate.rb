class Ratslate < Formula
  desc "An infinite canvas in the terminal: boxes, arrows and text, placed with the mouse, written out as ASCII"
  homepage "https://github.com/azihsoyn/ratslate"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.1.2/ratslate-aarch64-apple-darwin.tar.xz"
      sha256 "1bd3a02fe95d8a20cb82303e72007bf58c9b14e7f981e77f08f139ba135559e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.1.2/ratslate-x86_64-apple-darwin.tar.xz"
      sha256 "cb40d7c837ba13dc74110ddaba65c0aae42a245ed93453b4829ab970908ef278"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.1.2/ratslate-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0569b041489ce6f3addb83b5cd8d8d023961f2f4d91d06aad5f481edb9462fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/ratslate/releases/download/v0.1.2/ratslate-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c500153d4920488a064d95e5f249c40a27f7da8a3ab7cde2a49ea54bdf304e42"
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
