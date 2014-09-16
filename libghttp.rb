require "formula"

class Libghttp < Formula
  homepage "http://linux.maruhn.com/sec/libghttp.html"
  url "https://github.com/benswift/libghttp/archive/1.0.9.zip"
  sha1 "1db5e52e0c9ea16e34a4f3ceb4c95e23fa8ec83f"

  def install
    system "make"
    include.install "ghttp.h"
    lib.install "libghttp.dylib"
  end
end
