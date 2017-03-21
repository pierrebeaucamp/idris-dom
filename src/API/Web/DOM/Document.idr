module API.Web.DOM.Document

import API.Web.DOM.EventTarget
import API.Web.DOM.Node
import IdrisScript

%access public export
%default total

interface Node document => Document document where
  getElementById : document -> String -> JSRef

record DOMDocument where
  constructor NewDOMDocument
  characterSet : String

EventTarget DOMDocument where
  addEventListener doc = ?rhs

Node DOMDocument where
  contains doc = ?rhs

Document DOMDocument where
  getElementById doc = ?rhs

documentFromJSRef : JSRef -> JS_IO DOMDocument
documentFromJSRef document = map NewDOMDocument characterSet where
  characterSet : JS_IO String
  characterSet = jscall "%0.characterSet" (JSRef -> JS_IO String) document

