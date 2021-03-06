--    Copyright 2017, the blau.io contributors
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--        http://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.

module API.Web.DOM.EventTarget

import API.Web.DOM.Document
import API.Web.DOM.DocumentType
import API.Web.DOM.Element
import API.Web.DOM.Event
import API.Web.DOM.EventListener
import API.Web.DOM.Node
import API.Web.HTML.Document
import API.Web.HTML.Window
import API.Web.XHR.XMLHttpRequest
import API.Web.XHR.XMLHttpRequestEventTarget
import IdrisScript

%access public export
%default total

||| An EventTarget represents the target to which an event is dispatched when
||| something has occured.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-eventtarget
data EventTarget : Type where
  FromNode   : Node                      -> EventTarget
  FromWindow : Window                    -> EventTarget
  FromXHR    : XMLHttpRequestEventTarget -> EventTarget

record EventListenerOptions where
  constructor NewEventListenerOptions
  ||| When set to true, capture prevents **callback** from being invoked when
  ||| the event's `eventPhase` attribute value is `BUBBLING_PHASE`. When false,
  ||| **callback** will not be invoked when event's `eventPhase` attribute value
  ||| is `CAPTURING_PHASE`. Either way, **callback** will be invoked if event's
  ||| `eventPhase` attribute value is `AT_TARGET`. Default is `false`.
  capture : Bool

||| AddEventListenerOptions sets listener-specific options.
record AddEventListenerOptions where
  constructor NewAddEventListenerOptions
  eventListenerOptions : EventListenerOptions
  ||| When set to true, passive indicates that the **callback** will not cancel
  ||| the event by invoked `preventDefault`. This is used to enable performace
  ||| optimizations described in
  ||| [§2.7 Observing event listeners](https://dom.spec.whatwg.org/#observing-event-listeners.
  ||| Default is false.
  passive : Bool
  ||| When set to true, once indicates that the **callback** will only be
  ||| invoked once after which the event listener will be removed.
  once    : Bool

addEL : (ref : JSRef) -> (type : String) -> (listener : EventListener) ->
      (options : EventListenerOptions) -> JS_IO ()
addEL ref type (New _ callback) options = ?rhs_2
  -- jscall "%0.addEventListener(%1, %2, %3)"
  -- (JSRef -> JSFn (JSRef -> JS_IO()) -> JS_IO ())

addEventListener : EventTarget -> (type : String) ->
                   (listener : EventListener) ->
                   (options : EventListenerOptions) -> JS_IO ()
addEventListener (FromXHR (FromXMLHttpRequest (NewXMLRequest ref))) = addEL ref
addEventListener (FromWindow (New _ ref))                           = addEL ref
addEventListener (FromNode   (FromDocument     (New _ ref)))        = addEL ref
addEventListener (FromNode   (FromDocumentType (New _ _ _ ref)))    = addEL ref
addEventListener (FromNode   (FromElement      (New _ ref)))        = addEL ref
addEventListener (FromNode (FromDocument (FromHTMLDocument _ (New ref)))) =
  addEL ref

