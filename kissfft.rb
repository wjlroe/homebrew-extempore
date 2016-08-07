require 'formula'

class Kissfft < Formula
  homepage 'http://sourceforge.net/projects/kissfft/'
  url 'http://downloads.sourceforge.net/project/kissfft/kissfft/v1_3_0/kiss_fft130.zip'
  version '1.3.0'
  sha256 '262392013ddcfa3402144d57632c4dd146ab5e88ee650724a6845322f1efa178'

  def install
    system ENV.cc, "kiss_fft.c", "tools/kiss_fftr.c",
                   "-I.", "-I/usr/include/malloc",
                   "-dynamiclib", "-current_version", "#{version}",
                   "-o", "kiss_fft.#{version}.dylib"
    system "ln", "-s", "kiss_fft.#{version}.dylib", "kiss_fft.dylib"
    include.install "kiss_fft.h"
    lib.install "kiss_fft.#{version}.dylib", "kiss_fft.dylib"
  end
end
