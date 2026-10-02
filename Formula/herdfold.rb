class Herdfold < Formula
  desc "Long text, laid out as facing pages you turn: a book reader across two herdr panes, with bookmarks, notes and an agent to ask"
  homepage "https://github.com/azihsoyn/herdfold"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.1.0/herdfold-aarch64-apple-darwin.tar.xz"
      sha256 "1f16cb630d19d05ea4361a09a40bcff380e32bdb43ca56f252fa5bd833a1d48f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.1.0/herdfold-x86_64-apple-darwin.tar.xz"
      sha256 "3f41cd12a4d9f63e41916019ff0747451498024ffba1d23db9c2c38d9423442b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.1.0/herdfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "10126c3cf18bdf40a2dc46fa18b289a1b578caaf98d21d9e3244161cae427963"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.1.0/herdfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65c6b73fc87d732a9ebed355b18d0bff489a30f3a389e98d66a5204d00ea1d62"
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
