#!/usr/bin/make -f

all: build

generate-pot:
	xgettext -o pardus-boot-repair.pot  -L Shell --keyword --keyword=eval_gettext ../pardus-boot-repair

build:
	@echo "Building the mo files"
	for file in `ls *.po`; do \
		lang=`echo $$file | sed 's/\.po//'`; \
		msgfmt -o $$lang.mo $$file; \
	done

install:
	for file in `ls *.po`; do \
	    lang=`echo $$file | sed 's/\.po//'`; \
	    mkdir -p $(DESTDIR)/usr/share/locale/$$lang/LC_MESSAGES/; \
	    install $$lang.mo $(DESTDIR)/usr/share/locale/$$lang/LC_MESSAGES/pardus-boot-repair.mo ;\
	done


update-po:
	for i in *.po; do \
		code=$$(echo $$i | sed 's/.po//'); \
		intltool-update --gettext-package=pardus-boot-repair --dist $$code; \
	done

clean:
	rm -f *.mo

# vim:ts=4
