class Ratslate < Formula
  desc "Infinite canvas in the terminal: boxes, arrows and text, placed with the mouse"
  homepage "https://github.com/azihsoyn/ratslate"
  url "https://github.com/azihsoyn/ratslate/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "58cfab994d5a7553614552beaf68a5978b3396fe193e6022dab7bf122872292b"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system bin/"ratslate", "--schema"
  end
end
