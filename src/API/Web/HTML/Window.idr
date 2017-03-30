module API.Web.HTML.Window

import API.Web.DOM.Document
import API.Web.HTML.Document
import IdrisScript

%access public export
%default total

record Window where
  constructor New
  ||| The `Document` associated with `window`.
  document : API.Web.HTML.Document.Document
  self     : Ptr

||| defaultWindow is a default implementation of Window, intended to be used in
||| in a browser.
defaultWindow : JS_IO Window
defaultWindow = New <$> document <*> self where
  self : JS_IO JSRef
  self = jscall "window" (JS_IO JSRef)

  refref : JS_IO JSRef
  refref = join $ jscall "%0.document" (JSRef -> JS_IO JSRef) <$> self

  document : JS_IO API.Web.HTML.Document.Document
  document = map API.Web.HTML.Document.New $ join $
             map documentFromPointer $ join $
             jscall "%0.document" (JSRef -> JS_IO JSRef) <$> self

