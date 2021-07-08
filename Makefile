all: docx html

HEADER=vsj21-header.md
MACRO=macros.sty
MARKDOWN=md/0-format.md md/1-introduction.md md/2-relatedwork.md md/3-syuhou.md md/4-system.md md/5-evaluation.md md/6_conclusion.md md/b-bibliography.md 
INPUTS=$(HEADER) $(MACRO) $(MARKDOWN)

DOCX=vsj21-ota.docx
HTML=vsj21-ota.html

define pandoc
  pandoc \
    --from markdown+latex_macros \
    --citeproc \
    --bibliography=library.bib \
    $(INPUTS) \
    $(1)
endef
#    引用の形式を Chicogo 形式でなく APA 形式に変更する場合は以下の行を指定する。
#    --csl=etc/apa.csl \

docx: $(DOCX)
$(DOCX): $(INPUTS) etc/smartnova21.docx
	$(call pandoc, --reference-doc=etc/smartnova21.docx --output $@)

html: $(HTML)
$(HTML): $(INPUTS)
	$(call pandoc, --standalone --mathjax --css etc/page.css --output $@)

echohtml:
	@echo $(HTML)

clean:
	rm -f $(DOCX) $(HTML)
