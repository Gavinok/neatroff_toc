.fp - R HR
.fp - HD HB
.so test.idx
.de toc.gen
.	nr toc.i \\$1
.	br
.	mk
.	nr toc.ll (\\n[.l]u-\w'\\*[toc.\\n[toc.i].name]')
.	nr toc.ll (\\n[toc.ll]u-\w'\\n[toc.\\n[toc.i].num]')
.	ad l
.	post.url "#toc.\\n[toc.i]" "\\*[toc.\\n[toc.i].name]"
\l'\\n[toc.ll]u-'
.	br
.	rt
.	ad r
.	br
\\n[toc.\\n[toc.i].num]
.	nr toc.i +1
.	if !(\\n[toc.i]=\\n[toc.total]) \{\
.		toc.gen \\n[toc.i]
.	\}
..
.de toc
.if \\n[toc.init] \{\
.	sp
.	ce
\\*[toc.tl]
.	toc.gen 0
.\}
.br
.ad l
..
.ds toc.tl TABLE OF CONTENTS
.
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
