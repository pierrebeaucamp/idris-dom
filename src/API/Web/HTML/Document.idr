module API.Web.HTML.Document

import API.Web.DOM.Document

%access public export
%default total

||| The WHATWG DOM standard defines a `Document` interface, which this extends
||| significantly.
|||
||| The original interface specification can be found at
||| https://html.spec.whatwg.org/multipage/browsers.html#the-window-object
record Document where
  constructor New
  document : API.Web.DOM.Document.Document
