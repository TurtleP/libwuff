TARGET	:= libwuff

INCLUDE	:=	include/wuff_config.h \
			include/wuff_convert.h \
			include/wuff_internal.h \
			include/wuff.h

source	:=	source/wuff_convert.c \
			source/wuff_internal.c \
			source/wuff_memory.c \
			source/wuff.c

OBJFILES	:=	$(SOURCE:.c=.o)

CC		:= gcc
CFLAGS	:= -g -Wall $(INCLUDE)
LDFLAGS	:=


all: $(TARGET).a

clean:
	@echo clean ...
	@rm -fr $(OBJFILES) $(TARGET)

$(TARGET): $(OBJFILES)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJFILES) $(LDFLAGS)


dist-bin: all
	@tar --exclude=*~ -cjf $(TARGET)-$(VERSION).tar.bz2 include lib

install: dist-bin
	mkdir -p $(DESTDIR)$(DEVKITPRO)/libwuff
	bzip2 -cd $(TARGET)-$(VERSION).tar.bz2 | tar -xf - -C $(DESTDIR)$(DEVKITPRO)/libwuff
