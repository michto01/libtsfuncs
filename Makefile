CC = $(CROSS)$(TARGET)gcc
LINK = $(CROSS)$(TARGET)ld -o
LIBRARY_LINK_OPTS =  -L. -r
CFLAGS = -ggdb -D_GNU_SOURCE -Wall -Wextra -Wshadow -Wformat-security -O2
RM = /bin/rm -f
Q=@

OBJS = log.o tsfuncs.o crc.o misc.o time.o \
	sections.o secdata.o \
	descs.o \
	pat.o pat_desc.o \
	cat.o \
	pmt.o \
	nit.o nit_desc.o \
	sdt.o sdt_desc.o \
	eit.o eit_desc.o \
	tdt.o tdt_desc.o \
	pes.o pes_data.o \
	pes_es.o \
	privsec.o
PROG = libts.a

tstest_OBJS = tstest.o libts.a
all: $(PROG) tstest

$(PROG): $(OBJS) tsdata.h tsfuncs.h
	$(Q)echo "  LINK	$(PROG)"
	$(Q)$(LINK) $@ $(LIBRARY_LINK_OPTS) $(OBJS)

tstest: $(tstest_OBJS)
	$(Q)echo "  LINK	$(PROG)"
	$(Q)$(CC) $(CFLAGS) $(tstest_OBJS) -o tstest

%.o: %.c tsdata.h tsfuncs.h
	$(Q)echo "  CC	libts	$<"
	$(Q)$(CC) $(CFLAGS) -c $<

clean:
	$(Q)echo "  RM	$(PROG) $(OBJS)"
	$(Q)$(RM) $(PROG) tstest *.o *~

distclean: clean
