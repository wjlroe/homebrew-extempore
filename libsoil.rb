require 'formula'

class Libsoil < Formula
  homepage 'https://github.com/DeVaukz/SOIL'
  url 'https://github.com/DeVaukz/SOIL/archive/1.07.zip'
  sha1 '6cbb7d800a49c8df33bbe7146c6c67fb454a9777'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
