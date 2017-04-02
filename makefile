.PHONY: docs

default:
	idris -p idrisscript -i src

docs:
	rm -rf docs;            \
	idris --mkdoc web.ipkg; \
	mv web_doc docs

deps:
	cd lib/IdrisScript;               \
	idris --install idrisscript.ipkg; \
	cd -

test:
	idris --checkpkg web.ipkg
