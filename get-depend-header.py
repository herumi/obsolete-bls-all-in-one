#!/usr/bin/env python
import os, sys, re

RE=re.compile(r'cybozulib/include/cybozu/(.*hpp):')
def get_dependency(fname):
	s = set()
	with open(fname, 'rb') as f:
		for w in f.read().split():
			r = RE.search(w)
			if r:
				s.add(r.group(1))
		return s

def main():
	if len(sys.argv) == 1:
		print "get-depend-header.py <obj-dir> [<obj-dir2>...]"
		return 1
	s = set()
	for i in xrange(1, len(sys.argv)):
		depDir = sys.argv[i] + '/'
		for fname in os.listdir(depDir):
			if fname.endswith('.d'):
				s = s.union(get_dependency(depDir + fname))
	for h in s:
		print h,

if __name__ == '__main__':
	main()

