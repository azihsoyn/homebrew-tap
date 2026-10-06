class Herdfold < Formula
  desc "Long text, laid out as facing pages you turn: a book reader across two herdr panes, with bookmarks, notes and an agent to ask"
  homepage "https://github.com/azihsoyn/herdfold"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.5.0/herdfold-aarch64-apple-darwin.tar.xz"
      sha256 "6224b0e0d61e4b02b403ffe1c0e61e679b3d96151df43d11889109e6235f2334"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.5.0/herdfold-x86_64-apple-darwin.tar.xz"
      sha256 "82983cd7c24b8066bf6fea847311135aa23c03c17e7160fe87d095a1e92141cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.5.0/herdfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ec72f59769cc8a167a897aec22cebabfc216769d8f2b8cc60437df5230894f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.5.0/herdfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c72fac901be2402961c14cbfc28d3434353e16f04fae567dba1438c49b42e2d2"
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
