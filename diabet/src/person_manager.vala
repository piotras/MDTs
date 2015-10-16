/*
** Copyright (C) 2015 Piotr Pokora <piotrek.pokora@gmail.com>
*/

namespace Diabet {

	public abstract class PersonManager : GLib.Object  {
		/**
		 * Get the person with the given name.
		 * 
		 * @param name the name of the person
		 *
		 * @return Person object with the given name
		 *
		 * @throws NoSuchPersonException if the peron with such name doesn't exist
		 */
		public abstract Person get_person(string name) throws NoSuchPersonException;

		/**
		 * Updates person in the storage
		 * 
		 * @param person Person object to update
		 * 
		 * @return void
		 * 
		 */ 
		public abstract void update_person(Person person);

		/**
		 * Creates person in the storage
		 * 
		 * @param person Person object to create in storage
		 * 
		 * @return void
		 *
		 */
		public abstract void create_person(Person person);
	}
}
