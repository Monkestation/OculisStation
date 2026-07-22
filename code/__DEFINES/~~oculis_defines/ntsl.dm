/*
 * Macros: Status Macros
 */
///Indicates that the current function is returning a value.
#define RETURNING (1<<0)
///Indicates that the current loop is being terminated.
#define BREAKING (1<<2)
///Indicates that the rest of the current iteration of a loop is being skipped.
#define CONTINUING (1<<3)
///Indicates that we are entering a new function and the allowed_status var should be cleared
#define RESET_STATUS (1<<4)

/// If something is an 'object' to scripting.
#define IS_OBJECT(thing) (istype(thing, /datum) || istype(thing, /list) || istype(thing, /savefile) || istype(thing, /client) || (thing==world))
