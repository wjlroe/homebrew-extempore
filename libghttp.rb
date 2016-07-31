require "formula"

class Libghttp < Formula
  homepage "http://linux.maruhn.com/sec/libghttp.html"
  url "https://github.com/benswift/libghttp/archive/1.0.9.zip"
  sha256 "25b5440bbaddd7f6c6a1cd68769cf59c70c7af80a19dcb54797ef1a3d526d57d"

  def install
    system "make"
    include.install "ghttp.h"
    lib.install "libghttp.dylib"
  end
end
