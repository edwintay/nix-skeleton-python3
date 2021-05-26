#!/usr/bin/env python

import sys

for ix in range(5):
    print(f"{ix}")

for ix in xrange(5):
    print "%d" % ix

sys.exit(0)
