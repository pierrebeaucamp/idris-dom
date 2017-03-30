module API.Web.DOM.Document

import IdrisScript

%access public export
%default total

||| A Document represents any web page loaded in the browser and servers as an
||| entry point into the web page's content. which is the DOM tree.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-document
record Document where
  constructor New
  contentType : String
  ||| self is a non standard field which is used to facilitate integration with
  ||| Javascript.
  self        : Ptr

||| documentFromPointer is a helper function for easily creating Documents from
||| JavaScript references.
documentFromPointer : JSRef -> JS_IO Document
documentFromPointer self = New <$> contentType <*> pure self where
  contentType : JS_IO String
  contentType = jscall "%0.contentType" (JSRef -> JS_IO String) self

