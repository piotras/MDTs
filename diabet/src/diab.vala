/*
** Copyright (C) 2015 Piotr Pokora <piotrek.pokora@gmail.com>
*/

namespace Diabet {

	public abstract class Manager : GLib.Object  {

		/**
		 * Get the PersonManager.
		 * 
		 * @param void
		 *
		 * @return {@link PersonManager} instance
		 * 
		 * @throws DiabetException if error occurs
		 */
		public virtual PersonManager get_person_manager() throws DiabetException {
			throw new DiabetException.INTERNAL("NIE");	
		}

		/**
		 * Get the BolusManager.
		 *
		 * @param void
		 *
		 * @return {@link BolusManager} instance
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract BolusManager  get_bolus_manager();

		/**
		 * Get the BolusHistoryManager
		 * 
		 * @param void
		 *
		 * @return {@link BolusManager} instance
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract BolusHistoryManager get_bolus_history_manager();
	}
}
