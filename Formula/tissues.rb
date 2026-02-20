class Tissues < Formula
  desc "AI-enhanced GitHub issue creation with built-in safety guardrails"
  homepage "https://tissues.cc"
  url "https://registry.npmjs.org/tissues/-/tissues-0.4.0.tgz"
  sha256 "b70d72b2807ecad067c28a75e7f8c59d95f29e093c5c707e20d12c10548ab885"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", "--global", "--prefix", libexec, "."
    bin.install_symlink libexec/"bin/tissues"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tissues --version")
  end
end
