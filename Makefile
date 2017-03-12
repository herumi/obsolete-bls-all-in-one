all:
	$(MAKE) -C bls test
run_go:
	$(MAKE) -C bls run_go
clean:
	$(MAKE) -C bls clean

update: build_mcl update_mcl update_xbyak update_cybozulib update_bls

build_mcl:
	$(MAKE) -C ../mcl

update_mcl:
	rm -rf mcl
	mkdir -p mcl/include/mcl mcl/obj mcl/src/asm mcl/lib
	cp -a ../mcl/include/mcl/*.hpp mcl/include/mcl/
	cp -a ../mcl/include/mcl/*.h mcl/include/mcl/
	cp -a ../mcl/src/*.cpp mcl/src/
	cp -a ../mcl/src/*.hpp mcl/src/
	cp -a ../mcl/src/asm/*.s mcl/src/asm/
	cp -a $(addprefix ../mcl/,COPYRIGHT Makefile common.mk readme.md) mcl/
	cp -a ../mcl/obj/.emptydir mcl/obj/
	cp -a ../mcl/lib/.emptydir mcl/lib/

update_xbyak:
	rm -rf xbyak
	mkdir -p xbyak/xbyak
	cp -a ../xbyak/xbyak/*.h xbyak/xbyak/
	cp -a $(addprefix ../xbyak/,COPYRIGHT readme.md) xbyak/

CYBOZULIB_HEADERS=$(shell python get-depend-header.py ../mcl/obj)
update_cybozulib:
	rm -rf cybozulib
	mkdir -p cybozulib/include/cybozu
	cp -a $(addprefix ../cybozulib/include/cybozu/,$(CYBOZULIB_HEADERS)) cybozulib/include/cybozu
	cp -a $(addprefix ../cybozulib/,COPYRIGHT readme.md) cybozulib/

update_bls:
	rm -rf bls
	cd ../bls && git checkout-index -a --prefix=../bls-all-in-one/bls/
