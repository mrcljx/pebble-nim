import panicoverride
include pebble

proc select_click_handler(click_recognizer: ClickRecognizerRef, context: pointer) {.noconv.} =
  let text_layer = cast[ptr TextLayer](context)
  text_layer_set_text(text_layer, "Select!")

proc up_click_handler(click_recognizer: ClickRecognizerRef, context: pointer) {.noconv.} =
  let text_layer = cast[ptr TextLayer](context)
  text_layer_set_text(text_layer, "Up!")

proc down_click_handler(click_recognizer: ClickRecognizerRef, context: pointer) {.noconv.} =
  let text_layer = cast[ptr TextLayer](context)
  text_layer_set_text(text_layer, "Down!")

proc click_config_provider(context: pointer) {.noconv.} =
  window_single_click_subscribe(BUTTON_ID_UP, up_click_handler)
  window_single_click_subscribe(BUTTON_ID_SELECT, select_click_handler)
  window_single_click_subscribe(BUTTON_ID_DOWN, down_click_handler)

proc window_load_handler(window: ptr Window) {.noconv.} =
  app_log(APP_LOG_LEVEL_DEBUG, "window loaded!")
  let window_layer = window_get_root_layer(window)
  let window_bounds = layer_get_bounds(window_layer)

  let text_bounds = GRect(
    origin: GPoint(x: 0, y: 72),
    size: GSize(w: window_bounds.size.w, h: 20)
  )
  let text_layer = text_layer_create(text_bounds)

  text_layer_set_text(text_layer, "Press a button")
  layer_add_child(window_layer, text_layer_get_layer(text_layer))

  window_set_click_config_provider_with_context(window, click_config_provider, text_layer)

proc main(): int {.exportc.} =
  app_log(APP_LOG_LEVEL_DEBUG, "Pebble-y Nim, Nim-y Pebble");
  let window = window_create()
  let window_handlers = WindowHandlers(load: window_load_handler)
  window_set_window_handlers(window, window_handlers)
  window_stack_push(window, true)
  app_event_loop()
  0
