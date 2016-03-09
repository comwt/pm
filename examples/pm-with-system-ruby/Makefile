#
# feel free to change these to whatever makes sense
#
# debian package we rely on
RUBY_PACKAGE=ruby
# and the executable that comes from it
RUBY_BIN=/usr/bin/ruby
# the version we name the deb
VERSION=1.1.0
# where to get the sauce
GIT_URL=https://github.com/comwt/pm.git
# the tag we checkout to build from
TAG_SPEC=refs/tags/v$(VERSION)

CHECKOUT_DIR=pm-checkout
BUILD_DIR=build
LIB_DIR=$(BUILD_DIR)/usr/lib/pm
BIN_DIR=$(BUILD_DIR)/usr/bin
GEM_PATH:=$(shell readlink -f .)/build/gem
PM_BIN=$(BIN_DIR)/pm
BUNDLE_BIN=$(GEM_PATH)/bin/bundle
BUNDLE_CMD=$(RUBY_CMD) $(BUNDLE_BIN)
PM_CMD=$(PM_BIN)
GEM_CMD=$(RUBY_BIN) -S gem

.PHONY: clean
clean:
	rm -rf $(CHECKOUT_DIR)
	rm -rf $(BUILD_DIR)
	rm -f pm*.deb

$(CHECKOUT_DIR):
	rm -rf $(CHECKOUT_DIR)
	git clone $(GIT_URL) $(CHECKOUT_DIR) --depth 1
	cd $(CHECKOUT_DIR) && git fetch && git checkout $(TAG_SPEC)

$(BUNDLE_BIN):
	$(GEM_CMD) install bundler --install-dir=$(GEM_PATH) --no-ri --no-rdoc

$(PM_BIN):
	mkdir --parents $(BIN_DIR)
# 	Couldn't think of a nice way to do this, so here is this code turd
	echo "#! $(RUBY_BIN)" > $(PM_BIN)
	echo 'load File.dirname($$0) + "/../lib/pm/bundle/bundler/setup.rb"' >> $(PM_BIN)
	echo 'require "pm"'  >> $(PM_BIN)
	echo 'require "pm/command"' >> $(PM_BIN)
	echo 'exit(PM::Command.run || 0)' >> $(PM_BIN)
	chmod +x $(PM_BIN)

.PHONY: install
install: $(CHECKOUT_DIR) $(BUNDLE_BIN) $(PM_BIN)
	mkdir --parents $(LIB_DIR)
	cd $(CHECKOUT_DIR) && GEM_PATH=$(GEM_PATH) $(BUNDLE_CMD) install --without=development --standalone
	cd $(CHECKOUT_DIR) && gem build pm.gemspec
	tar -xf $(CHECKOUT_DIR)/pm*gem -C $(BUILD_DIR)
	tar --touch -xf $(BUILD_DIR)/data.tar.gz -C $(LIB_DIR)
	cp -r $(CHECKOUT_DIR)/bundle $(LIB_DIR)/bundle

.PHONY: package
package: install
	$(PM_BIN) -s dir -t deb -n pm -d $(RUBY_PACKAGE) -v $(VERSION) -C $(BUILD_DIR) usr
