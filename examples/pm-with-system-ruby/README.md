# About

 - build and install dependency on a ruby1.9 of some kind
 - does not need root to package
 - has its own GEM_DIR to keep its dependencies isolated
 - installation does not install any gems in to your ruby environment
 - installs in to standard locations /usr/{bin,lib}/pm
 - doesn't depend on having pm installed for packaging to work

# Dependencies

 - build-essential (perhaps more, but basically the standard packages you need
   for deb packaging)
 - ruby and ruby-dev

# Usage

 - $ cd examples/pm-with-system-ruby && make package
