PROG ?= login
PREFIX ?= /usr
DESTDIR ?= 
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions
MANDIR ?= $(PREFIX)/share/man
BASHCOMPDIR ?= $(PREFIX)/etc/bash_completion.d

all:
	@echo "pass-$(PROG) is a shell script and does not need compilation, it can be simply executed."
	@echo ""
	@echo "To install it try \"make install\" instead."
	@echo

install:
	@install -vd "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/" \
		"$(DESTDIR)$(MANDIR)/man1" \
		"$(DESTDIR)$(BASHCOMPDIR)"
	@install -vm0755 $(PROG).bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash"
	@install -vm 0644 "completion/pass-$(PROG).bash" "$(DESTDIR)$(BASHCOMPDIR)/pass-$(PROG)"
	@install -vm 0644 "pass-$(PROG).1" "$(DESTDIR)$(MANDIR)/man1/pass-$(PROG).1"
	@echo
	@echo "pass-$(PROG) is installed succesfully"
	@echo

uninstall:
	@rm -vrf \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/$(PROG).bash" \
		"$(DESTDIR)$(BASHCOMPDIR)/pass-$(PROG)" \
		"$(DESTDIR)$(MANDIR)/man1/pass-$(PROG).1"

lint:
	shellcheck --shell bash $(PROG).bash

check: lint

.PHONY: install uninstall lint check
