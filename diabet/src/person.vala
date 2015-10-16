/*
 * Copyright (C) 2015 Piotr Pokora <piotrek.pokora@gmail.com>
 */

namespace Diabet {

	enum BolusType {
		SIMPLE,
		EXTENDED
	}

	public interface Person : GLib.Object  {

		/**
		 * Get the name.
		 *
		 * @param void
		 *
		 * @return the name of the person
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract void get_name();

		/**
		 * Get the type of the bolus available for the person.
		 *
		 * BolusType.SIMPLE for simple injection
		 * BolusType.EXTENDED for insulin pump
		 *
		 * @param void
		 *
		 * @return the type of the bolus
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract void get_bolus_type();

		/**
		 * Set the type of the bolus available for the person.
		 *
		 * BolusType.SIMPLE for simple injection
		 * BolusType.EXTENDED for insulin pump
		 *
		 * @param void
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract void set_bolus_type(int bolus_type);

		/* baza */
		/**
		 * Set basal rate at given hour.
		 * Basal rate starts at given hour and last for next hour.
		 *
		 * For example, set_basal_rate_at(14, 0,6) means that '0,6' basal rate starts at
		 * 14 (2pm) and last till 15 (3pm).
		 *
		 * @param hour An hour in 24 hours format
		 * @param basal a basal rate
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract void set_basal_rate_at(int hour, float basal);
		
		/**
		 * Get basal rate at given hour.
		 *
		 * @param hour An hour in 24 hours format
		 *
		 * @throws DiabetException if error occurs
		 */
		public abstract float get_basal_rate_at(int hour);

		/* o ile wzrosnie poziom cukru we krwi po spożyciu jednego wymiennika / CF */
		public abstract void set_bg_raise_level_per_ten_carbo(int level);
		public abstract int get_bg_raise_level_per_ten_carbo();

		/* o ile zostanie obniżony poziom cukru po podaniu jednej jednostki */
		public abstract void set_bg_level_lower_per_insulin_unit(int level);
		public abstract int get_bg_level_lower_per_insulin_unit();

		public abstract void set_cir_at(int cir, int hour);
		public abstract int get_cir_at(int hour);
		/* o ile jedna jednostka zbija poziom cukru / CIR */
		/**
		 * The number of grams of carb that are covered by 1 unit of insulin.
		 * 
		 * Medtronic calls it insulin-to-carbohydrate (ICR).
		 * Sooil seems to call it carbohydrate-to-insulin CIR)
		 *
		 * From medtronic's manual:
		 * 
		 * For example, if you need 1 unit of insulin to cover 10 grams of carb,
		 * your ICR is 10. If your ICR is 10, and you ate 20 grams, you would take 2 units
		 * of insulin to cover the 20 grams of carb
		 *
		 */
		public abstract void set_carbo_to_insulin(int cir); 
		public abstract int get_carbo_to_insulin();
	}
}
