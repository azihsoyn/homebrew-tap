class Herdfold < Formula
  desc "Long text, laid out as facing pages you turn: a book reader across two herdr panes, with bookmarks, notes and an agent to ask"
  homepage "https://github.com/azihsoyn/herdfold"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.2.0/herdfold-aarch64-apple-darwin.tar.xz"
      sha256 "3d5969d9d93ab6e69cc55aec3cdd0de8532ab99aebea2b93ca136661b5e4b161"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.2.0/herdfold-x86_64-apple-darwin.tar.xz"
      sha256 "f6dd3bac1f38659ccd59dcefa346976f2b4afe5b4d5c242a5196be7ba35f42a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.2.0/herdfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2fc4e48a367bde50d7a7155d5e15e55f6159e8d511dfdd0f70f0915a9bee9f47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.2.0/herdfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e193f047ec8818e9261b1aefcd0f242af22f5710126d9867f562d1b11a03042b"
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
