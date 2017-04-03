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

module API.Web.DOM.Document

import API.Web.DOM.DocumentType
import API.Web.HTML.Document
import IdrisScript

%access public export
%default total

||| A Document represents any web page loaded in the browser and servers as an
||| entry point into the web page's content. which is the DOM tree.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-document
data Document : Type where
  FromHTMLDocument : API.Web.HTML.Document.Document ->
                     API.Web.DOM.Document.Document
  ||| self is a non standard field which is used to facilitate integration with
  ||| Javascript.
  New : (docType : DocumentType) -> (self : Ptr) ->
        API.Web.DOM.Document.Document

||| documentFromPointer is a helper function for easily creating Documents from
||| JavaScript references.
|||
||| @ self a pointer to a document
documentFromPointer : (self : JSRef) ->
                      JS_IO $ Maybe API.Web.DOM.Document.Document
documentFromPointer self = case !maybeDocType of
    Nothing        => pure Nothing
    (Just docType) => case docType of
      -- A document is said to be an *XML document* if its type is "`xml`", and
      -- an *HTML document* otherwise.
      -- NOTE: This could be a good use case for dependent types
      (New "xml" _ _) => pure $ Just $ New docType self
      (New _     _ _) => pure $ Just $ FromHTMLDocument $
                         API.Web.HTML.Document.New docType self
  where
    maybeDocType : JS_IO $ Maybe DocumentType
    maybeDocType = join $ map documentTypeFromPointer $
                   jscall "%0.docType" (JSRef -> JS_IO JSRef) self

