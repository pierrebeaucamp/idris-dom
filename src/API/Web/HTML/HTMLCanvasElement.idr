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

module API.Web.HTML.HTMLCanvasElement

import IdrisScript

%access public export
%default total

||| The HTMLCanvasElement provides scripts with a resolution-dependent bitmap
||| canvas, which can be used for rendering graphs, game graphics, art, or other
||| visual images on the fly.
|||
||| The original specification can be found at
||| https://html.spec.whatwg.org/#the-canvas-element
record HTMLCanvasElement where
  constructor New
  width, height : Int
  localName : String

||| htmlCanvasElementFromPointer is a helper function for easily creating 
||| HTMLCanvasElements from JavaScript references.
|||
||| @ ref A pointer to an HTMLCanvasElement.
htmlCanvasElementFromPointer : (ref : JSRef) -> JS_IO $ Maybe HTMLCanvasElement
htmlCanvasElementFromPointer ref = case !maybeLocalName of
    Nothing          => pure Nothing
    (Just localName) => case !maybeWidth of
      Nothing      => pure Nothing
      (Just width) => case !maybeHeight of
        Nothing       => pure Nothing
        (Just height) => pure $ Just $ New width height localName
  where
    maybeLocalName : JS_IO $ Maybe String
    maybeLocalName = let
        getLocalName = jscall "%0.localName" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getLocalName) of
             (JSString ** str) => pure $ Just $ fromJS str
             _                 => pure Nothing

    maybeWidth : JS_IO $ Maybe Int
    maybeWidth = let
        getWidth = jscall "%0.width" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getWidth) of
             (JSNumber ** num) => pure $ Just $ fromJS num
             _                 => pure Nothing

    maybeHeight : JS_IO $ Maybe Int
    maybeHeight = let
        getHeight = jscall "%0.height" (JSRef -> JS_IO JSRef) ref
      in
        case !(IdrisScript.pack !getHeight) of
             (JSNumber ** num) => pure $ Just $ fromJS num
             _                 => pure Nothing

