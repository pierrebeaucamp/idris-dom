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

module API.Web.HTML.HTMLElement

import API.Web.HTML.HTMLCanvasElement
import IdrisScript

%access public export
%default total

||| The HTMLElement is the interface from which all the HTML elements'
||| interfaces inherit, and which must be used by elements that have no
||| additional requirements.
|||
||| The original specification can be found at
||| https://html.spec.whatwg.org/#htmlelement
data HTMLElement : Type where
  FromHTMLCanvasElement : HTMLCanvasElement    -> HTMLElement
  New                   : (localName : String) -> HTMLElement

||| htmlElementFromPointer is a helper function for easily creating HTMLElements
||| from JavaScript references.
|||
||| @ ref A pointer to an HTMLElement.
htmlElementFromPointer : (ref : JSRef) -> JS_IO $ Maybe HTMLElement
htmlElementFromPointer ref = case !maybeLocalName of
    Nothing          => pure Nothing
    (Just localName) => case localName of
      "canvas" => case !(htmlCanvasElementFromPointer ref) of
        Nothing       => pure Nothing
        (Just canvas) => pure $ Just $ FromHTMLCanvasElement canvas
      _        => pure $ Just $ New localName
  where
    maybeLocalName : JS_IO $ Maybe String
    maybeLocalName = let
        getLocalName = jscall "%0.localName" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getLocalName) of
             (JSString ** str) => pure $ Just $ fromJS str
             _                 => pure Nothing

