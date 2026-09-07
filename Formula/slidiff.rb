class Slidiff < Formula
  desc "A slide deck an agent writes and a person reads in the terminal — slides point at file:line, the viewer draws the real diff, and review progress travels back"
  homepage "https://github.com/azihsoyn/slidiff"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.2/slidiff-aarch64-apple-darwin.tar.xz"
      sha256 "83a261d675d78d07842a799988e05c527183eabc634f06919e52aa345119cbd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.2/slidiff-x86_64-apple-darwin.tar.xz"
      sha256 "1f9d2ab56992f04ae3afd6b35dd7de97026331ec032affb75e9338a440053f93"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.2/slidiff-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e1d7c352798f1ab03f0e4e4ccff4022bb5d7a0e67e67804be991ef73f5cef0c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/slidiff/releases/download/v0.1.2/slidiff-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e57e0bc55324fc9996550b501220ed0c6f2144db4f1660f70d0689552a3c16f1"
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
