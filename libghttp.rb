require "formula"

class Libghttp < Formula
  homepage "http://linux.maruhn.com/sec/libghttp.html"
  url "https://github.com/benswift/libghttp/archive/1.0.9.zip"
  sha1 "884e32331f338eda5d4fd5facf01bc26b6b5d607"

  def install
    system "make"
    include.install "ghttp.h"
    lib.install "libghttp.dylib"
  end
end
