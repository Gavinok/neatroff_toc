.fp - R HR
.fp - HD HB
.so tmac.toc
.so test.idx
.toc
.bp
.sp 5
Welcome to \m[#727]Neatroff\m[]!

In modern times condign headlights show us how step-daughters can be

.post.name "hello"
.rn SH SH_
.de SH
.	SH_ "\\$*"
.	post.mark "\\$*"
.	post.name "toc.\\n[toc.idx]"
.	tm INDEX.ds toc.\\n[toc.idx].name \\$*
.	tm INDEX.nr toc.\\n[toc.idx].num \\n[.%]
.	nr toc.idx +1
.	tm INDEX.nr toc.total \\n[toc.idx]
.	tm INDEX.nr toc.init 1
..

.SH First heading
.SH Second heading
.SH 3rd heading
.bp

.SH 4th heading
.bp
.SH This is once again a heading
