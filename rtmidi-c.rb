require 'formula'

class RtmidiC < Formula
  homepage 'https://github.com/benswift/rtmidi-c-api'
  url 'https://github.com/benswift/rtmidi-c-api/archive/master.zip'
  sha1 '9225c0f05b0c1070cc31fe81518634e7dce0a4ab'
  version '0.1'
  
  def install
    system "make", "-f", "Makefile-osx"
    include.install('RtError.h', 'RtMidi-C-Api.h', 'RtMidi.h')
    lib.install('librtmidic.dylib')
  end
end
