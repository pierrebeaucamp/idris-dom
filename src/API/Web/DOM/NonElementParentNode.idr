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

module API.Web.DOM.NonElementParentNode

import API.Web.DOM.Document
import API.Web.DOM.Element
import IdrisScript

%access public export
%default total

||| The original specification of NonElementParentNode can be found at
||| https://dom.spec.whatwg.org/#interface-nonelementparentnode
data NonElementParentNode : Type where
  FromDocument : Document -> NonElementParentNode

||| Returns the first element within a *node*'s descendatns whose ID is
||| *elmId*.
getElementById : NonElementParentNode -> (elmId : String) -> JS_IO Element
getElementById (FromDocument (New _ docRef)) elmId = join $
  map elementFromPointer $
  jscall "%0.getElementById(%1)" (JSRef -> String -> JS_IO JSRef) docRef elmId