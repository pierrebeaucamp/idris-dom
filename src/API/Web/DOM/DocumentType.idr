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

import IdrisScript

%access public export
%default total

||| The original specification can be found at
||| https://dom.spec.whatwg.org/#interface-documenttype
record DocumentType where
  constructor New
  name     : String
  publicId : String
  systemId : String
  self     : JSRef

||| documentTypeFromPointer is a helper function for easily creating
||| DocumentTypes from JavaScript references.
|||
||| @ ref a pointer to a documentType
documentTypeFromPointer : (ref : JSRef) -> JS_IO $ Maybe DocumentType
documentTypeFromPointer ref = let
    nameRef     = jscall "%0.name"     (JSRef -> JS_IO JSRef) ref
    publicIdRef = jscall "%0.publicId" (JSRef -> JS_IO JSRef) ref
    systemIdRef = jscall "%0.systemId" (JSRef -> JS_IO JSRef) ref
  in
    case !(IdrisScript.pack !nameRef) of
      (JSString ** name) => case !(IdrisScript.pack !publicIdRef) of
        (JSString ** pubId) => case !(IdrisScript.pack !systemIdRef) of
          (JSString ** sysId) => pure $ Just $
                                 New (fromJS name) (fromJS pubId) (fromJS sysId)
                                      ref
          _                   => pure Nothing
        _                   => pure Nothing
      _                  => pure Nothing

