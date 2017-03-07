# root Makefile for holding all basic targets

all: update

update:
	(git submodule update --init --recursive .)

clean:

purge: clean

.PHONY: all update clean purge

.DEFAULT_GOAL=all
