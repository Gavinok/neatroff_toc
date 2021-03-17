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

TARGET = toc

.SUFFIXES: .tr .preidx .idx .ms .ps .pdf
all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).ms $(TARGET).idx

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

.PHONY: deploy
deploy: $(TARGET).pdf ## For deploying the pdf to server
	./deploy $< 

clean:
	rm -f *.ps  *.pdf *.preidx *.idx
