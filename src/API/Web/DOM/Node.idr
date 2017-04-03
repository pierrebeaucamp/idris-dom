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

module API.Web.DOM.Node

import API.Web.DOM.Document
import API.Web.DOM.DocumentType
import API.Web.DOM.Element

%access public export
%default total

||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-node
data Node : Type where
  FromDocument     : Document     -> Node
  FromDocumentType : DocumentType -> Node
  FromElement      : Element      -> Node

