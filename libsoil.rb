require 'formula'

class Libsoil < Formula
  homepage 'https://github.com/DeVaukz/SOIL'
  url 'https://github.com/DeVaukz/SOIL/archive/1.07.zip'
  sha256 '14a1ad3550ed9e51ec20941fd25f007215394cedc35531a22b21dee2a86c6cd4'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
