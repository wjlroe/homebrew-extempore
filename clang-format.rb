require "formula"

class ClangFormat < Formula
  homepage "http://llvm.org/releases/download.html"
  url "http://llvm.org/releases/3.5.0/clang+llvm-3.5.0-macosx-apple-darwin.tar.xz"
  sha1 "ea15cfe99022fb2abce219d7e8a4377b81f7b1fb"

  def install
    bin.install('bin/clang-format')
  end

  test do
    system "#{bin}/clang-format", "-version"
  end
end
