class Tissues < Formula
  desc "AI-enhanced GitHub issue creation with built-in safety guardrails"
  homepage "https://tissues.cc"
  url "https://registry.npmjs.org/tissues/-/tissues-0.5.1.tgz"
  sha256 "361bf2f8db84185942ae1999b08690a56f2df2769fb3fb8437c99ad6dd031687"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "pack"
    system "npm", "install", *std_npm_args, "tissues-#{version}.tgz"
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
