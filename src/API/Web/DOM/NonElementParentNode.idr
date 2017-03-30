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
