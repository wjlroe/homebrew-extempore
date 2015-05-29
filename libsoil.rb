require 'formula'

class Libsoil < Formula
  homepage 'https://github.com/DeVaukz/SOIL'
  url 'https://github.com/DeVaukz/SOIL/archive/1.07.zip'
  sha1 '4422d522e7f3ad6b047dab2924c6dadb7a4884d8'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
