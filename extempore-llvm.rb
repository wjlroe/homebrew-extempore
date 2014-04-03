require 'formula'

class ExtemporeLlvm < Formula
  homepage  'http://llvm.org/'
  url       'http://llvm.org/releases/3.2/llvm-3.2.src.tar.gz'
  sha1      '42d139ab4c9f0c539c60f5ac07486e9d30fc1280'
  keg_only "This is a specially patched LLVM for use in building Extempore."

  option 'with-asan', 'Include support for -faddress-sanitizer (from compiler-rt)'
  option 'all-targets', 'Build all target backends'
  option 'rtti', 'Build with C++ RTTI'
  option 'disable-assertions', 'Speeds up LLVM, but provides less debug information'

  def patches
    # patch llparser (bugfix) for Extempore use
    DATA
  end

  def install
    CompilerRt.new("compiler-rt").brew do
      (buildpath/'projects/compiler-rt').install Dir['*']
    end if build.include? 'with-asan'

    ENV['REQUIRES_RTTI'] = '1' if build.include? 'rtti'

    args = [
      "--prefix=#{prefix}",
      "--enable-optimized",
      # As of LLVM 3.1, attempting to build ocaml bindings with Homebrew's
      # OCaml 3.12.1 results in errors.
      "--disable-bindings",
    ]

    if build.include? 'all-targets'
      args << "--enable-targets=all"
    else
      args << "--enable-targets=host"
    end

    args << "--disable-assertions" if build.include? 'disable-assertions'

    system "./configure", *args
    system "make install"

  end

  def caveats; <<-EOS.undent
    This is a specifically patched version of LLVM for building Extempore.
    It shouldn't get in the way of any other LLVM install.

    If you have any problems, raise them on extemporelang@googlegroups.com
    EOS
  end

end

__END__
diff -ruN a/include/llvm/Support/CFG.h b/include/llvm/Support/CFG.h
--- a/include/llvm/Support/CFG.h
+++ b/include/llvm/Support/CFG.h
@@ -27,8 +27,9 @@
 
 template <class Ptr, class USE_iterator> // Predecessor Iterator
 class PredIterator : public std::iterator<std::forward_iterator_tag,
-                                          Ptr, ptrdiff_t> {
-  typedef std::iterator<std::forward_iterator_tag, Ptr, ptrdiff_t> super;
+                                          Ptr, ptrdiff_t, Ptr*, Ptr*> {
+  typedef std::iterator<std::forward_iterator_tag, Ptr, ptrdiff_t, Ptr*,
+                                                                    Ptr*> super;
   typedef PredIterator<Ptr, USE_iterator> Self;
   USE_iterator It;
 
@@ -40,6 +41,7 @@
 
 public:
   typedef typename super::pointer pointer;
+  typedef typename super::reference reference;
 
   PredIterator() {}
   explicit inline PredIterator(Ptr *bb) : It(bb->use_begin()) {
@@ -50,7 +52,7 @@
   inline bool operator==(const Self& x) const { return It == x.It; }
   inline bool operator!=(const Self& x) const { return !operator==(x); }
 
-  inline pointer operator*() const {
+  inline reference operator*() const {
     assert(!It.atEnd() && "pred_iterator out of range!");
     return cast<TerminatorInst>(*It)->getParent();
   }
@@ -100,10 +102,11 @@
 
 template <class Term_, class BB_>           // Successor Iterator
 class SuccIterator : public std::iterator<std::bidirectional_iterator_tag,
-                                          BB_, ptrdiff_t> {
+                                          BB_, ptrdiff_t, BB_*, BB_*> {
   const Term_ Term;
   unsigned idx;
-  typedef std::iterator<std::bidirectional_iterator_tag, BB_, ptrdiff_t> super;
+  typedef std::iterator<std::bidirectional_iterator_tag, BB_, ptrdiff_t, BB_*,
+                                                                    BB_*> super;
   typedef SuccIterator<Term_, BB_> Self;
 
   inline bool index_is_valid(int idx) {
@@ -112,6 +115,7 @@
 
 public:
   typedef typename super::pointer pointer;
+  typedef typename super::reference reference;
   // TODO: This can be random access iterator, only operator[] missing.
 
   explicit inline SuccIterator(Term_ T) : Term(T), idx(0) {// begin iterator
@@ -142,7 +146,7 @@
   inline bool operator==(const Self& x) const { return idx == x.idx; }
   inline bool operator!=(const Self& x) const { return !operator==(x); }
 
-  inline pointer operator*() const { return Term->getSuccessor(idx); }
+  inline reference operator*() const { return Term->getSuccessor(idx); }
   inline pointer operator->() const { return operator*(); }
 
   inline Self& operator++() { ++idx; return *this; } // Preincrement
diff -ruN a/lib/AsmParser/LLParser.cpp b/lib/AsmParser/LLParser.cpp
--- a/lib/AsmParser/LLParser.cpp
+++ b/lib/AsmParser/LLParser.cpp
@@ -1349,8 +1349,14 @@
     // If the type hasn't been defined yet, create a forward definition and
     // remember where that forward def'n was seen (in case it never is defined).
     if (Entry.first == 0) {
-      Entry.first = StructType::create(Context, Lex.getStrVal());
-      Entry.second = Lex.getLoc();
+        // this here for extempore
+  	if (M->getTypeByName(Lex.getStrVal())) {
+           Entry.first = M->getTypeByName(Lex.getStrVal());
+           Entry.second = SMLoc();
+        } else {	
+      	   Entry.first = StructType::create(Context, Lex.getStrVal());
+           Entry.second = Lex.getLoc();
+	}
     }
     Result = Entry.first;
     Lex.Lex();
