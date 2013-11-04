require 'formula'

class Kissfft < Formula
  homepage 'http://sourceforge.net/projects/kissfft/'
  url 'http://downloads.sourceforge.net/project/kissfft/kissfft/v1_3_0/kiss_fft130.zip'
  version '1.3.0'
  sha1 '292f06a7a6fcb658e01d97dad71cfd679741b3fb'

  def install
    system "gcc kiss_fft.c tools/kiss_fftr.c -dynamiclib -I. -I/usr/include/malloc -o kiss_fft.1.3.0.dylib -current_version 1.3.0"
    system "ln -s kiss_fft.1.3.0.dylib kiss_fft.dylib"
    include.install "kiss_fft.h"
    lib.install "kiss_fft.1.3.0.dylib", "kiss_fft.dylib"
  end
end
