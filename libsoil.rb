require 'formula'

class Libsoil < Formula
  homepage 'https://github.com/DeVaukz/SOIL'
  url 'https://codeload.github.com/DeVaukz/SOIL/zip/master'
  version '1.07'
  sha1 '7114eb45fd2c8da5177e1dad663d4e09ce403842'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
