CFLAGS = -Wall -g `pkg-config --cflags glib-2.0;  pkg-config --cflags midgard2; pkg-config --cflags gio-2.0`
LDFLAGS = `pkg-config --libs glib-2.0;  pkg-config --libs midgard2; pkg-config --libs gio-2.0; pkg-config --libs gthread-2.0`

all: \
	async \
	schedule \
	create	

async: async.c
	$(CC) -o async async.c $(CFLAGS) $(LDFLAGS)

schedule: schedule.c
	$(CC) -o schedule schedule.c $(CFLAGS) $(LDFLAGS)

create: create_objects.c
	$(CC) -o create-objects create_objects.c $(CFLAGS) $(LDFLAGS)

clean:
	rm -f *~
	rm -f *.o
	rm -f async
	rm -f schedule
