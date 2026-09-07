class Slidiff < Formula
  desc "Slide decks agents write, anchored to real diffs, read in the terminal"
  homepage "https://github.com/azihsoyn/slidiff"
  url "https://github.com/azihsoyn/slidiff/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "5862314bc69b19fc800e131b919d0c1685fecbac1aeb723baf3b74d1a2cec569"
  license "MIT"
  head "https://github.com/azihsoyn/slidiff.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "slidiff", shell_output("#{bin}/slidiff --help")
  end
end
