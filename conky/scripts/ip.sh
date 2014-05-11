#!/bin/bash
wget --no-proxy http://checkip.dyndns.org/ -q -O - |
grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>'
