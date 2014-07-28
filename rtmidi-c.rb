require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi'
  url 'https://github.com/benswift/rtmidi/archive/master.zip'
  sha1 '27a702b472f13423c2da7915c8c2fbc4b6ec225e'
  version '0.2'

  def install
    system "./make-rtmidic.sh"
    include.install "RtMidiC.h", "RtMidi.h"
    lib.install "librtmidic.dylib"
  end
end
