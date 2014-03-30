SOURCES = $(wildcard *.odg)
TARGETS = $(SOURCES:.odg=.pdf)

# we can convert odg to pdf with:
# * libreoffice --convert-to pdf
# * cups-printer
# * unoconv

%.pdf:%.odg
	libreoffice --convert-to pdf --invisible "$^"

all: $(TARGETS)

clean:
	rm -f $(TARGETS)
