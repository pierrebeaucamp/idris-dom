default:
	idris -p idrisscript -i src

install:
	cd lib/IdrisScript;               \
	idris --install idrisscript.ipkg; \
	cd -
