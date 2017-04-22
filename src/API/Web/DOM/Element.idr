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

import API.Web.HTML.HTMLElement
import API.Web.Infra.Namespaces
import IdrisScript

%access public export
%default total

||| An Element represents an object of a Document.
|||
||| The original specification can be found at
||| https://dom.spec.whatwg.org/#interface-element
data Element : Type where
  FromHTMLElement : HTMLElement          -> Element
  New             : (localName : String) -> (self : JSRef) -> Element

||| elementFromPointer is a helper function for easily creating Elements from
||| JavaScript references.
|||
||| @ ref A pointer to an element
elementFromPointer : (ref : JSRef) -> JS_IO $ Maybe Element
elementFromPointer ref = case !maybeNamespace of
    Nothing   => pure Nothing
    (Just ns) => case !maybeLocalName of
      Nothing          => pure Nothing
      (Just localName) => case ns of
        API.Web.Infra.Namespaces.html => case !(htmlElementFromPointer ref) of
          Nothing            => pure Nothing
          (Just htmlElement) => pure $ Just $ FromHTMLElement htmlElement
        _                             => pure $ Just $ New localName ref
  where
    maybeNamespace : JS_IO $ Maybe String
    maybeNamespace = let
        getNameSpace = jscall "%0.namespaceURI" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getNameSpace) of
             (JSString ** str) => pure $ Just $ fromJS str
             _                 => pure Nothing

    maybeLocalName : JS_IO $ Maybe String
    maybeLocalName = let
        getLocalName = jscall "%0.localName" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getLocalName) of
             (JSString ** str) => pure $ Just $ fromJS str
             _                 => pure Nothing

