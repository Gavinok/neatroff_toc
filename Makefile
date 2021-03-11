# Neatroff demonstration directory
BASE = $(PWD)/..
ROFF = "$(BASE)/neatroff/roff"
POST = "$(BASE)/neatpost/post"
PPDF = "$(BASE)/neatpost/pdf"
EQN = "$(BASE)/neateqn/eqn"
REFR = "$(BASE)/neatrefer/refer"
PIC = "$(BASE)/troff/pic/pic"
TBL = "$(BASE)/troff/tbl/tbl"
SOIN = "$(BASE)/soin/soin"

ROFFOPTS = "-F$(BASE)" "-M$(BASE)/tmac"
POSTOPTS = "-F$(BASE)" -pletter
ROFFMACS = -mpost -men
REFROPTS = -m -e -o ct -p ref.bib

all: finalpdf

.SUFFIXES: .tr .preidx .idx .ms .ps .pdf

finalpdf: test.idx test.pdf 

.tr.ps:
	@echo "Generating $@"
	@cat $< | $(PIC) | $(TBL) | $(EQN) | $(ROFF) $(ROFFOPTS) | $(POST) $(POSTOPTS) >$@

.ms.preidx: ## First pass of the file
	@echo "Generating $@"
	@cat $< | $(SOIN) | \
		$(REFR) $(REFROPTS) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) $(ROFFMACS) 2>$@ | $(POST) $(POSTOPTS)  >/dev/null

.preidx.idx: ## Generate index file
	@echo "Generating $@"
	cat $< | grep '^INDEX' | sed 's/^INDEX//' >$@

.ms.ps: ## Generate postscript file
	@echo "Generating $@"
	@cat $< | $(SOIN) | \
		$(REFR) $(REFROPTS) | $(PIC) | $(TBL) | $(EQN) | \
		$(ROFF) $(ROFFOPTS) $(ROFFMACS) | $(POST) $(POSTOPTS) >$@

.ps.pdf: ## Generate pdf
	@echo "Generating $@"
	@ps2pdf -dPDFSETTINGS=/prepress -dEmbedAllFonts=true \
		"-sFONTPATH=$(BASE)/fonts/" "-sFONTMAP=$(BASE)/fonts/Fontmap" $< $@

clean:
	rm -f *.ps  *.pdf *.preidx *.idx
