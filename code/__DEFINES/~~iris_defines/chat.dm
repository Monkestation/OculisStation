/// No italics
#define conditional_tooltip_alt(normal_text, tooltip_text, condition) ((condition) ? (span_tooltip_alt(tooltip_text, normal_text)) : (normal_text))
