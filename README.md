CEM application written in Alpaca
========================================

This app measures temerature and compresses the data using LZW compression.
For testing purpose it uses pseudo-random input.

Build:

	$ make bld/gcc/depclean
	$ make bld/gcc/dep
	$ make bld/alpaca/depclean
	$ make bld/alpaca/dep
	$ make bld/alpaca/all

Flash:

	$ make bld/alpaca/prog
