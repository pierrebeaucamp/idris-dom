module API.Web.HTML.Window

import API.Web.DOM.Document
import API.Web.HTML.Document
import IdrisScript

%access public export
%default total

||| The Window represents a window containing a DOM document.
|||
||| The original interface specification can be found at
||| https://html.spec.whatwg.org/multipage/browsers.html#the-window-object
record Window where
  constructor New
  ||| The `Document` associated with `window`.
  document : API.Web.HTML.Document.Document

||| defaultWindow is a default implementation of Window, intended to be used in
||| in a browser.
defaultWindow : JS_IO Window
defaultWindow = map New $
                map API.Web.HTML.Document.New $
                map API.Web.DOM.Document.New cType where

  cType : JS_IO String
  cType = jscall "window.document.contentType" (JS_IO String)


