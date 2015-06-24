class Libnanovg < Formula
  homepage "https://github.com/memononen/nanovg"
  head "https://github.com/memononen/nanovg.git"

  depends_on 'premake' => :build

  def patches
    DATA
  end

  def install
    system "premake4", "gmake"
    cd "build"
    system "make", "config=release64", "nanovg"
    cd ".."
    include.install ["src/nanovg.h", "src/nanovg_gl.h"]
    lib.install "build/libnanovg.dylib"
  end
end

__END__
diff a/premake4.lua b/premake4.lua
--- a/premake4.lua
+++ b/premake4.lua
@@ -8,11 +8,11 @@ solution "nanovg"
 	
    	project "nanovg"
 		language "C"
-		kind "StaticLib"
+		kind "SharedLib"
 		includedirs { "src" }
 		files { "src/*.c" }
 		targetdir("build")
-		defines { "_CRT_SECURE_NO_WARNINGS" } --,"FONS_USE_FREETYPE" } Uncomment to compile with FreeType support
+    defines { "_CRT_SECURE_NO_WARNINGS",  "NANOVG_GL3_IMPLEMENTATION" }
 		
 		configuration "Debug"
 			defines { "DEBUG" }
@@ -22,6 +22,9 @@ solution "nanovg"
 			defines { "NDEBUG" }
 			flags { "Optimize", "ExtraWarnings"}
 
+		configuration { "macosx" }
+			linkoptions { "-framework OpenGL" }
+
 	project "example_gl2"
 
 		kind "ConsoleApp"

diff a/src/nanovg.c b/src/nanovg.c
--- a/src/nanovg.c
+++ b/src/nanovg.c
@@ -24,6 +24,10 @@
 #define STB_IMAGE_IMPLEMENTATION
 #include "stb_image.h"
 
+// to make sure that nvgCreatexxx gets build into the shared lib
+#include <OpenGL/gl3.h>
+#include "nanovg_gl.h"
+
 #ifdef _MSC_VER
 #pragma warning(disable: 4100)  // unreferenced formal parameter
 #pragma warning(disable: 4127)  // conditional expression is constant
