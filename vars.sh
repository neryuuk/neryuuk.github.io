#!/bin/bash

export TAG="neryuuk.github.io"
export V_RUBY=`grep -E '^ruby' Gemfile | grep -Eo '[0-9.]+'`;
export V_GEMS="3.6.4";
export V_BUNDLER="2.6.4";

if [[ -z ${VOLUME+x} ]]; then export VOLUME=.; fi;
