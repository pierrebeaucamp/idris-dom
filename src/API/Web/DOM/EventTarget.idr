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

import API.Web.DOM.Event
import API.Web.DOM.EventListener
import API.Web.DOM.Node
import API.Web.HTML.Window

%access public export
%default total

||| An EventTarget represents the target to which an event is dispatched when
||| something has occured.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-eventtarget
data EventTarget : Type where
  FromWindow : Window -> EventTarget
  FromNode   : Node   -> EventTarget

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

||| Appends an EventListener for events whose `type` attribute value is *type*.
|||
||| @ target   the event target
||| @ type     the type of event the eventlistener is subscribing to
||| @ listener the eventlistener itself
||| @ options  the options object for the eventlistener
addEventListener : (target : EventTarget) -> (type : String) ->
                   (listener : EventListener) ->
                   (options : AddEventListenerOptions) -> IO ()
addEventListener target eventType listener options = ?addEventListener_rhs_1

||| Removes the EventListener in *target*'s list of event listeners with the
||| same *type* and *options*.
|||
||| @ target   the event target
||| @ type     the type of event the eventlistener is subscribing to
||| @ listener the eventlistener itself
||| @ options  the options object for the eventlistener
removeEventListener : (target : EventTarget) -> (type : String) ->
                      (listener : EventListener) ->
                      (options: EventListenerOptions) -> IO ()
removeEventListener target eventType listener options = ?removeEventListener_rhs_1

||| Dispatches a synthetic event *event* to *target* and returns true if either
||| *event*'s `cancelable` attribute value is false or its `preventDefault`
||| method was not invoked, and false otherwise.
|||
||| @ target the event target
||| @ event  the event to dispatch
dispatchEvent : (target : EventTarget) -> (event : Event) -> IO Bool
dispatchEvent target event = ?dispatchEvent_rhs_1

