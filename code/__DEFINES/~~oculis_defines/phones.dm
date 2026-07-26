#define TIME_TO_RING 10 SECONDS

#define USABLE_RADIO_FREQUENCY_FOR_PHONE_RANGE 2000
#define MAX_RADIO_FREQUENCY_FOR_PHONE_RANGE 3000

#define PHONE_AVAILABLE 0
#define PHONE_RINGING 1
#define PHONE_CALLING 2
#define PHONE_IN_CALL 3

#define PHONE_NO_SIM (1<<1)
#define PHONE_OPEN (1<<2)

DEFINE_BITFIELD(phone_flags, list(
	"PHONE_NO_SIM" = PHONE_NO_SIM,
	"PHONE_OPEN" = PHONE_OPEN,
))

// Icons used for call history logging
#define PHONE_CALL_ACCEPTED "fa-phone-volume"
#define PHONE_CALL_DECLINED "fa-phone-slash"
#define PHONE_CALL_RECEIVED "fa-phone"
#define PHONE_CALL_MISSED "fa-history"
#define PHONE_CALL_SENT "fa-share"
#define PHONE_CALL_ENDED "fa-tty"

#define PHONE_CALL_ACCEPTED_TOOLTIP "Phone call accepted"
#define PHONE_CALL_DECLINED_TOOLTIP "Phone call declined"
#define PHONE_CALL_RECEIVED_TOOLTIP "Phone call received"
#define PHONE_CALL_MISSED_TOOLTIP "Phone call missed"
#define PHONE_CALL_SENT_TOOLTIP "Phone call sent"
#define PHONE_CALL_ENDED_TOOLTIP "Phone call ended"
