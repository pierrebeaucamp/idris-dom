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

module API.Web.DOM.Element

import IdrisScript

%access public export
%default total

||| An Element represents an object of a Document.
|||
||| The original specification can be found at
||| https://dom.spec.whatwg.org/#interface-element
record Element where
  constructor New
  localName : String

||| elementFromPointer is a helper function for easily creating Elements from
||| JavaScript references.
elementFromPointer : JSRef -> JS_IO Element
elementFromPointer ref = map New $
                         jscall "%0.localName" (JSRef -> JS_IO String) ref