module API.Web.DOM.EventListener

import API.Web.DOM.Event

%access public export
%default total

||| An EventListener can be used to observe a specific event.
|||
||| The original specification can be found at
||| https://dom.spec.whatwg.org/#concept-event-listener
record EventListener where
  constructor New
  type     : String
  ||| The *callback* arguments sets the **callback** that will be invoked when
  ||| the event get dispatched.
  callback : Event -> IO ()
  capture  : Bool
  passive  : Bool
  once     : Bool
  removed  : Bool -- for bookkeeping purposes

handleEvent : EventListener -> Event -> IO ()
handleEvent (New _ callback _ _ _ _) event = callback event

