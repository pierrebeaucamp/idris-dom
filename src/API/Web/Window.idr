module API.Web.Window

import API.Web.DOM.HTMLDocument
import IdrisScript

%access public export
%default total

record Window where
  constructor NewWindow
  document : Document

defaultWindow : JS_IO Window
defaultWindow = map NewWindow document where
  document : JS_IO Document
  document = jscall "window.document" (JS_IO JSRef)

