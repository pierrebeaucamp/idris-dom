module API.Web.DOM.Document

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

