require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi'
  url 'https://github.com/benswift/rtmidi/archive/master.zip'
  sha256 '79dbd9fef0433ed5666b562151dd1f7d9010de71c4f09b236c75029b6f399976'
  version '0.2'

  def install
    system "./make-rtmidic.sh"
    include.install "RtMidiC.h", "RtMidi.h"
    lib.install "librtmidic.dylib"
  end
end
