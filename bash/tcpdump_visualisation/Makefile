LAYOUT=circo
SOURCES = $(wildcard *.dot)
TARGETS = $(SOURCES:.dot=.svg)

%.svg:%.dot
	dot -Tsvg -K${LAYOUT} "$^" -o "$@"

all: $(TARGETS)

clean:
	rm -f $(TARGETS)
