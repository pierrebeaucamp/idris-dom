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

module API.Web.HTML.Window

import API.Web.DOM.Document
import API.Web.HTML.Document
import IdrisScript

%access public export
%default total

record Window where
  constructor New
  ||| The `Document` associated with `window`.
  document : API.Web.HTML.Document.Document
  self     : Ptr

||| defaultWindow is a default implementation of Window, intended to be used in
||| in a browser.
defaultWindow : JS_IO Window
defaultWindow = New <$> document <*> self where
  self : JS_IO JSRef
  self = jscall "window" (JS_IO JSRef)

  refref : JS_IO JSRef
  refref = join $ jscall "%0.document" (JSRef -> JS_IO JSRef) <$> self

  document : JS_IO API.Web.HTML.Document.Document
  document = map API.Web.HTML.Document.New $ join $
             map documentFromPointer $ join $
             jscall "%0.document" (JSRef -> JS_IO JSRef) <$> self

