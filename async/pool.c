
#include <glib.h>
#include <gio/gio.h>
#include <glib-object.h>
#include <midgard/midgard.h>

static void 
pool_func (gpointer data, gpointer user_data) 
{
	MidgardObject *object = MIDGARD_OBJECT (data);
	MidgardConnection *mgd = MIDGARD_CONNECTION (user_data);
	g_print ("Sleep in a thread [%p] \n", g_thread_self());
	g_usleep (3000000);
	static guint i = 0;
	static GMutex mutex;
	g_mutex_lock (&mutex);
	i++;
	g_mutex_unlock (&mutex);
	g_print ("(%d) Create object, THREAD [%p] \n", i, g_thread_self());
	midgard_object_create (object);
	g_print ("'%s' \n", midgard_connection_get_error_string (mgd));
	return;
}

int
main (int argc, char **argv)
{
	midgard_init ();	

	MidgardConfig *config = midgard_config_new ();
	midgard_config_read_file_at_path (config, "/tmp/test_SQLITE.conf", NULL);

	MidgardConnection *mgd = midgard_connection_new ();
	midgard_connection_open_config (mgd, config);

	GThreadPool *pool = g_thread_pool_new (pool_func, (gpointer) mgd, 10, TRUE, NULL);


	//midgard_storage_create_base_storage (mgd);
	//midgard_storage_create (mgd,"midgard_snippetdir");
	
	g_print ("START OPERATIONS \n");

	MidgardObject *obj = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	g_thread_pool_push (pool, (gpointer) obj, NULL);

	MidgardObject *obja = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	g_thread_pool_push (pool, (gpointer) obja, NULL);

	MidgardObject *objb = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	g_thread_pool_push (pool, (gpointer) objb, NULL);
	
	MidgardObject *objc = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	g_thread_pool_push (pool, (gpointer) objc, NULL);
	
	MidgardObject *objd = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	g_thread_pool_push (pool, (gpointer) objd, NULL);

	g_print ("END OPERATIONS \n");

	g_print ("THREADS REMAIN (%d) \n", g_thread_pool_unprocessed (pool));	

	g_thread_pool_free (pool, FALSE, TRUE);

	return 0;
}
