
#include <glib.h>
#include <gio/gio.h>
#include <glib-object.h>
#include <midgard/midgard.h>

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

	MidgardObject *obj = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	midgard_object_create (obj);

	MidgardObject *obja = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	midgard_object_create (obja);

	MidgardObject *objb = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	midgard_object_create (objb);

	MidgardObject *objc = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	midgard_object_create (objc);
	
	MidgardObject *objd = midgard_object_new (mgd, "midgard_snippetdir", NULL);
	midgard_object_create (objd);

	g_print ("END TEST FUNC \n");
	return 0;
}
