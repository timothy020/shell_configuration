#!/bin/bash

pkill notary;
rm -rf ~/Dev/notary_test/notary/notary-cpp/build/bin/server
rm -rf ~/.notary-cpp/server
rm -rf ~/.notary-cpp/server.log
rm -rf ~/.notary/tuf ~/.notary/private
rm -rf ~/.notary-cpp/tuf ~/.notary-cpp/private
