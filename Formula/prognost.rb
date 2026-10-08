class Prognost < Formula
  desc "Read a code change's prognosis before it ships: like terraform plan, for code — what a diff touches, how far it reaches through its callers, and what in that reach looks risky"
  homepage "https://github.com/azihsoyn/prognost"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/prognost/releases/download/v0.1.0/prognost-aarch64-apple-darwin.tar.xz"
      sha256 "ef082153376917c98720467b9afc2d6d4ff9262a33cd7d962191ac41d696a7bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/prognost/releases/download/v0.1.0/prognost-x86_64-apple-darwin.tar.xz"
      sha256 "e35cc92b8f152391de25ad98d146979878338371d677f840061dd0b5c259239e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/azihsoyn/prognost/releases/download/v0.1.0/prognost-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5c04043020be204f819d33114b8beb7fed067f062b3d8812ae84c628f0e7047a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/azihsoyn/prognost/releases/download/v0.1.0/prognost-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a7a067c5269526c4d25f08b6c425b26a1f298f67bf538cdceea4d7d22683774"
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
      bin.install "prognost"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "prognost"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "prognost"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "prognost"
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
