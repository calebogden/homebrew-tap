class Tissues < Formula
  desc "AI-enhanced GitHub issue creation with built-in safety guardrails"
  homepage "https://tissues.cc"
  url "https://registry.npmjs.org/tissues/-/tissues-0.5.2.tgz"
  sha256 "676af5cee7815c6bcad6259f73798634527e569c5bd34510c38660bb01de788b"
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
