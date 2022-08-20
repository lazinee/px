#!/usr/bin/env bash

pushd susvelo
git rebase --interactive upstream/upstream
popd
