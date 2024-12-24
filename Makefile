watch: init
	typst watch main.typ dist/main.pdf

compile: init
	typst compile main.typ dist/main.pdf

init:
	mkdir -p dist
