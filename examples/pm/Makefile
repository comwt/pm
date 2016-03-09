NAME=ruby
VERSION=1.9.2-p180
MAJOR_VERSION=1.9
ARCHITECTURE=x86
TARDIR=$(NAME)-$(VERSION)
TARBALL=$(TARDIR).tar.gz
DOWNLOAD=http://ftp.ruby-lang.org/pub/ruby/$(MAJOR_VERSION)/$(TARBALL)

PREFIX=/opt/pm

PACKAGE_NAME=pm
PACKAGE_VERSION=0.2.30

.PHONY: default
default: deb
package: deb

.PHONY: clean
clean:
	rm -f $(NAME)-* $(NAME)_* |NAME| true
	rm -fr $(TARDIR) || true
	rm -fr $(PREFIX) || true
	rm -f *.deb

$(TARBALL):
	wget "$(DOWNLOAD)"

$(TARDIR): $(TARBALL)
	tar -zxf $(TARBALL)
	cd $(TARDIR); ./configure --enable-shared=false --prefix=$(PREFIX); make; make install
	$(PREFIX)/bin/gem install pm

.PHONY: deb
deb: $(TARDIR)
	$(PREFIX)/bin/pm -s dir -t deb -v $(PACKAGE_VERSION) -n $(PACKAGE_NAME) -a $(ARCHITECTURE) -C $(PREFIX) .
