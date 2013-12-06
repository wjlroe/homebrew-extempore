require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi-c-api'
  url 'https://github.com/benswift/rtmidi-c-api/archive/master.zip'
  sha1 '44316c14783cefb5ad6cf966f15d00ce63453fbd'
  version '0.1'

  def install
    system "make", "-f", "Makefile-osx"
    include.install "RtError.h", "RtMidi-C-Api.h", "RtMidi.h"
    lib.install "librtmidic.dylib"
  end
end
