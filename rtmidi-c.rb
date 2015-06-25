require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi'
  url 'https://github.com/benswift/rtmidi/archive/master.zip'
  sha1 '3d34e3cbe3893121ee540fe90a8c164a9d846902'
  version '0.2'

  def install
    system "./make-rtmidic.sh"
    include.install "RtMidiC.h", "RtMidi.h"
    lib.install "librtmidic.dylib"
  end
end
