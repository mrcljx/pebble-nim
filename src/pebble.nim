{.push debugger:off, hints:off.}

type
  Layer {.importc, header:"<pebble.h>", nodecl.} = object
  TextLayer {.importc, header:"<pebble.h>", nodecl.} = object

  Window {.importc, header:"<pebble.h>", nodecl.} = object
  WindowHandler {.importc, header:"<pebble.h>", nodecl.} = proc(window: ptr Window) {.noconv.}
  WindowHandlers {.importc, header:"<pebble.h>", nodecl.} = object
    load: WindowHandler
    appear: WindowHandler
    disappear: WindowHandler
    unload: WindowHandler

  ClickHandler {.importc, header:"<pebble.h>", nodecl.} = proc(click_recognizer: ClickRecognizerRef, context: pointer) {.noconv.}
  ClickRecognizerRef {.importc:"Window", header:"<pebble.h>", nodecl.} = pointer
  ClickConfigProvider {.importc, header:"<pebble.h>", nodecl.} = proc(context: pointer) {.noconv.}

  AppLogLevel {.importc, header:"<pebble.h>", nodecl.} = enum
    APP_LOG_LEVEL_ERROR = 1
    APP_LOG_LEVEL_WARNING = 50
    APP_LOG_LEVEL_INFO = 100
    APP_LOG_LEVEL_DEBUG = 200
    APP_LOG_LEVEL_DEBUG_VERBOSE = 255

  ButtonId {.importc, header:"<pebble.h>", nodecl.} = enum
    BUTTON_ID_BACK
    BUTTON_ID_UP
    BUTTON_ID_SELECT
    BUTTON_ID_DOWN
    NUM_BUTTONS

  GRect {.importc, header:"<pebble.h>", nodecl.} = object
    origin: GPoint
    size: GSize

  GPoint {.importc, header:"<pebble.h>", nodecl.} = object
    x: int
    y: int

  GSize {.importc, header:"<pebble.h>", nodecl.} = object
    w: int
    h: int


proc app_event_loop() {.importc, header:"<pebble.h>", nodecl.}

proc window_create(): ptr Window {.importc, header:"<pebble.h>", nodecl.}

proc window_set_window_handlers(window: ptr Window, handlers: WindowHandlers) {.importc, header:"<pebble.h>", nodecl.}

proc window_stack_push(window: ptr Window, animated: bool) {.importc, header:"<pebble.h>", nodecl.}

proc window_stack_pop_all(animated: bool) {.importc, header:"<pebble.h>", nodecl.}

proc window_single_click_subscribe(id: ButtonId, click_handler: ClickHandler) {.importc, header:"<pebble.h>", nodecl.}

proc window_get_root_layer(window: ptr Window): ptr Layer {.importc, header:"<pebble.h>", nodecl.}

proc layer_get_bounds(layer: ptr Layer): GRect {.importc, header:"<pebble.h>", nodecl.}

proc layer_add_child(parent: ptr Layer, child: ptr Layer) {.importc, header:"<pebble.h>", nodecl.}

proc text_layer_set_text(text_layer: ptr TextLayer, text: cstring) {.importc, header:"<pebble.h>", nodecl.}

proc text_layer_create(frame: GRect): ptr TextLayer {.importc, header:"<pebble.h>", nodecl.}

proc text_layer_get_layer(text_layer: ptr TextLayer): ptr Layer {.importc, header:"<pebble.h>", nodecl.}

proc window_set_click_config_provider_with_context(window: ptr Window, click_config_provider: ClickConfigProvider, context: pointer) {.importc, header:"<pebble.h>", nodecl.}

proc app_log_internal(log_level: uint8, src_filename: cstring, src_line_number: int, format: cstring) {.importc:"app_log", header:"<pebble.h>", varargs, nodecl.}

# TODO: varargs
proc app_log(log_level: AppLogLevel, format: cstring) =
  app_log_internal(cast[uint8](log_level), "nim", 0, format)

{.pop.}
