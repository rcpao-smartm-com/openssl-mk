#!/bin/bash -vx

git clone https://github.com/openssl/openssl.git
pushd openssl
  PREFIX=/usr/local/ssl
  ./Configure --prefix=$PREFIX --openssldir=$PREFIX '-Wl,-rpath,$(LIBRPATH)'
  make
  make test
  sudo make install
  echo "$PREFIX/lib" | sudo tee -a /etc/ld.so.conf.d/openssl-3.5.0.conf
  sudo ldconfig -v
  $PREFIX/bin/openssl version -a
  # sudo vi $PREFIX/openssl.cnf
popd
