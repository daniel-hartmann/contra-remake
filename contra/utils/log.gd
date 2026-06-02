extends Node

enum Level {
	DEBUG,
	INFO,
	WARNING,
	ERROR
}

static var minimum_level := Level.DEBUG


static func debug(message: String):
	if minimum_level <= Level.DEBUG:
		print("[DEBUG] ", message)


static func info(message: String):
	if minimum_level <= Level.INFO:
		print("[INFO] ", message)


static func warning(message: String):
	if minimum_level <= Level.WARNING:
		push_warning(message)


static func error(message: String):
	if minimum_level <= Level.ERROR:
		push_error(message)
