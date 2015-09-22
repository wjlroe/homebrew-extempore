class LibkissFft < Formula
  homepage "http://kissfft.sourceforge.net/"
  url "https://github.com/benswift/kiss_fft/archive/1.3.0.zip"
  sha256 "7a4da573d126fee5b4d9aaf9124ff02b6b85206c1ee583e21703fef5f4f383f0"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
