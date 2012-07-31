CFLAGS = -Wall -g `pkg-config --cflags glib-2.0;  pkg-config --cflags midgard2; pkg-config --cflags gio-2.0`
LDFLAGS = `pkg-config --libs glib-2.0;  pkg-config --libs midgard2; pkg-config --libs gio-2.0; pkg-config --libs gthread-2.0`

NULL =

all: \
	async \
	async2 \
	schedule \
	create	\
	pool \
	$(NULL)

async: async.c
	$(CC) -o async async.c $(CFLAGS) $(LDFLAGS)

async2: async2.c
	$(CC) -o async2 async2.c $(CFLAGS) $(LDFLAGS)

schedule: schedule.c
	$(CC) -o schedule schedule.c $(CFLAGS) $(LDFLAGS)

create: create_objects.c
	$(CC) -o create-objects create_objects.c $(CFLAGS) $(LDFLAGS)

pool: pool.c
	$(CC) -o pool pool.c $(CFLAGS) $(LDFLAGS)

clean:
	rm -f *~
	rm -f *.o
	rm -f async
	rm -f async2
	rm -f schedule
	rm -f pool
