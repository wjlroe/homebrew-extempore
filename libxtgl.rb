require "formula"

class Libxtgl < Formula
  homepage "https://github.com/benswift/XTGL/"
  head "https://github.com/benswift/XTGL.git"
  sha1 ""

  def install
    system "make", "shared"
    include.install "include/xtgl.h"
    lib.install "libxtgl.dylib"
  end
end
