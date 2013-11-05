require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi-c-api'
  url 'https://github.com/benswift/rtmidi-c-api/archive/master.zip'
  sha1 '5e514d43131125a5b186a8e4725656dca5de309e'
  version '0.1'
  
  def install
    # this is pretty filthy.  Sorry everyone.
    system "g++ -dynamiclib -Wall -D__MACOSX_CORE__ RtMidi.cpp RtMidi-C-Api.cpp -framework CoreMIDI -framework CoreAudio -framework CoreFoundation -o librtmidic.dylib"
    include.install('RtError.h', 'RtMidi-C-Api.h', 'RtMidi.h')
    lib.install('librtmidic.dylib')
  end
end
