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
