class Tissues < Formula
  desc "AI-enhanced GitHub issue creation with built-in safety guardrails"
  homepage "https://tissues.cc"
  url "https://registry.npmjs.org/tissues/-/tissues-0.4.1.tgz"
  sha256 "a0e44eb95761f1d144bb693bf9c9c52dc7faf744d9be54909a992b9ce3d11d0a"
  license "MIT"

  depends_on "node"

  def install
    # npm install --global . creates a dangling symlink to the temp build dir.
    # Pack first so npm copies files properly rather than symlinking.
    system "npm", "pack"
    system "npm", "install", "--global", "--prefix", libexec, "tissues-#{version}.tgz"
    script = libexec/"lib/node_modules/tissues/bin/tissues.js"
    (bin/"tissues").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{script}" "$@"
    SH
    chmod 0755, bin/"tissues"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tissues --version")
  end
end
