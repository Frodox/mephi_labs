SOURCES_ODG = $(wildcard *.odg)
SOURCES_DOT = $(wildcard *.dot)

TARGETS_ODG = $(SOURCES_ODG:.odg=.pdf)
TARGETS_DOT = $(SOURCES_DOT:.dot=.pdf)

LIBREOFFICE_PID = $(shell pidof soffice.bin)


%.pdf:%.dot
	dot -Tpdf "$^" -o "$@"

%.pdf:%.odg
# we can convert odg to pdf with:
# * libreoffice --convert-to pdf
# * cups-printer
# * unoconv

ifneq ("", "$(LIBREOFFICE_PID)")
	$(error "Please, close all LibreOffice instances ($(LIBREOFFICE_PID)) to continue")
endif
	libreoffice --headless --convert-to pdf "$^"

all: $(TARGETS_ODG) $(TARGETS_DOT)

clean:
	rm -f $(TARGETS_ODG) $(TARGETS_DOT)
pdf:%.odg

