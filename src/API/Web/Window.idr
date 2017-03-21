module API.Web.Window

import API.Web.DOM.Document
import IdrisScript

%access public export
%default total

record Window where
  constructor NewWindow
  document : DOMDocument

defaultWindow : JS_IO Window
defaultWindow = map NewWindow document where
  document : JS_IO DOMDocument
  document = jscall "window.document" (JS_IO JSRef) >>= documentFromJSRef

