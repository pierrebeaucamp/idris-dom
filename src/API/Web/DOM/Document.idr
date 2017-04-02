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

import IdrisScript

%access public export
%default total

||| A Document represents any web page loaded in the browser and servers as an
||| entry point into the web page's content. which is the DOM tree.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-document
record Document where
  constructor New
  contentType : String
  ||| self is a non standard field which is used to facilitate integration with
  ||| Javascript.
  self        : Ptr

||| documentFromPointer is a helper function for easily creating Documents from
||| JavaScript references.
documentFromPointer : JSRef -> JS_IO $ Maybe Document
documentFromPointer self = case !maybeContentType of
    Nothing            => pure Nothing
    (Just contentType) => pure $ Just $ New contentType self
  where
    maybeContentType : JS_IO $ Maybe String
    maybeContentType = let
        getContentType = jscall "%0.contentType" (JSRef -> JS_IO JSRef) self
      in
        case !(IdrisScript.pack !getContentType) of
            (JSString ** str) => pure $ Just $ fromJS str
            _                 => pure Nothing

