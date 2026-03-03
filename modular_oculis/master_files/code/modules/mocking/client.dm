/datum/client_interface/proc/get_exp_living(pure_numeric = FALSE)
	if(!prefs?.exp?[EXP_TYPE_LIVING])
		return pure_numeric ? 0 : "No data"
	var/exp_living = text2num(prefs.exp[EXP_TYPE_LIVING])
	return pure_numeric ? exp_living : get_exp_format(exp_living)
