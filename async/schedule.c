
#include <glib.h>
#include <gio/gio.h>
#include <glib-object.h>
#include <midgard/midgard.h>

typedef struct {
	GMainLoop *loop;
	guint jobs;
	GSimpleAsyncResult *result;
} Holder;

static Holder* 
holder_new ()
{
	Holder *holder = g_new (Holder, 1);
	holder->jobs = 0;
	holder->loop = g_main_loop_new (NULL, FALSE);

	return holder;
}

typedef struct {
	GSimpleAsyncResult *result;
	Holder *holder;
	MidgardObject *object;
} ResultHolder;

static ResultHolder*
result_holder_new (Holder *holder)
{
	ResultHolder *result = g_new (ResultHolder, 1);
	result->holder = holder;
	result->result = NULL;
	result->object = NULL;

	return result;
}

static void 
cb (GObject *source, GAsyncResult *result, gpointer user_data) 
{
	ResultHolder *holder = (ResultHolder *) user_data;
	g_print ("(%d) Operation completed. Notyfing. \n", holder->holder->jobs);
	holder->holder->jobs--;
	if (holder->holder->jobs == 0) {
		g_main_loop_quit (holder->holder->loop);
	}
	return;
}

static gboolean 
scheduler_callback (GIOSchedulerJob *job, GCancellable *cancellable, gpointer user_data)
{	
	//g_usleep (1000000);
	ResultHolder *holder = (ResultHolder *)user_data;
	//g_print ("Create object, THREAD [%p] \n", g_thread_self());
	midgard_object_create (holder->object);
	g_simple_async_result_complete_in_idle (holder->result);
}

static void 
test_async(ResultHolder *holder)
{
	GSimpleAsyncResult *simple = g_simple_async_result_new (NULL, cb, holder, test_async);
	holder->result = simple;
	g_io_scheduler_push_job (scheduler_callback, holder, NULL, G_PRIORITY_DEFAULT, NULL);
	holder->holder->jobs++;
}

int
main (int argc, char **argv)
{
	midgard_init ();	

	MidgardConfig *config = midgard_config_new ();
	midgard_config_read_file_at_path (config, "/tmp/test_SQLITE.conf", NULL);

	MidgardConnection *mgd = midgard_connection_new ();
	midgard_connection_open_config (mgd, config);

	//midgard_storage_create_base_storage (mgd);
	//midgard_storage_create (mgd,"midgard_snippetdir");

	Holder *holder = holder_new ();
	
	g_print ("START OPERATIONS \n");

	ResultHolder *result = result_holder_new (holder);
	MidgardObject *obj = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	result->object = obj;
	test_async(result);

	ResultHolder *resulta = result_holder_new (holder);
	MidgardObject *obja = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	resulta->object = obja;
	test_async(resulta);

	ResultHolder *resultb = result_holder_new (holder);
	MidgardObject *objb = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	resultb->object = objb;
	test_async(resultb);

	ResultHolder *resultc = result_holder_new (holder);
	MidgardObject *objc = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	resultc->object = objc;
	test_async(resultc);

	ResultHolder *resultd = result_holder_new (holder);
	MidgardObject *objd = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	resultd->object = objd;
	test_async(resultd);

	g_print ("END OPERATIONS \n");

	g_main_loop_run (holder->loop);

	return 0;
}
