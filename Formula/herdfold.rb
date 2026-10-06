class Herdfold < Formula
  desc "Long text, laid out as facing pages you turn: a book reader across two herdr panes, with bookmarks, notes and an agent to ask"
  homepage "https://github.com/azihsoyn/herdfold"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.4.0/herdfold-aarch64-apple-darwin.tar.xz"
      sha256 "a20a644a7f9c8546a73ac205c7129667474b47e6de801af0792c3688843974b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.4.0/herdfold-x86_64-apple-darwin.tar.xz"
      sha256 "145693084b7b71e88d564dbed8d9e9f659a071488b5ab53c7ed4227206d9a59d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.4.0/herdfold-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2f3f916c2977b872e70c73add12e7566d2053923acb38ea655d01fcef3c44fde"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/herdfold/releases/download/v0.4.0/herdfold-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1804d88851ae5289675b7535a55eff810f45b0be67a9d5b540d5174ebc9096aa"
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
