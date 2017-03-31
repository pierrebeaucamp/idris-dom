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

