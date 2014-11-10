require "formula"

class SkeletonPic < Formula
  homepage "https://idre.ucla.edu/hpc/parallel-plasma-pic-codes"
  url "https://github.com/benswift/skeleton-pic/archive/0.1.0.zip"
  sha1 "8ff92661ed15dc7c8930768249ff3a3b428693a1"

  def install
    # pic2 (serial electrostatic)
    Dir.chdir "./pic2"
    system "make", "shared"
    include.install "push2.h"
    lib.install "libpic2.dylib"
    # bpic2 (serial electromagnetic)
    Dir.chdir "../bpic2"
    system "make", "shared"
    include.install "bpush2.h"
    lib.install "libbpic2.dylib"
  end

  def caveats
    s = ''
    s += <<-EOS.undent
      The basic serial electrostatic (libpic2) and electromagnetic (libbpic2)
      shared libraries have been installed.

      This is mostly useful for Extempore at the moment, but over time more of
      the included libs/binaries will be installed as well.
    EOS
  end

end
