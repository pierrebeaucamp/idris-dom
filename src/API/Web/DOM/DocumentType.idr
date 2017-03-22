module API.Web.DOM.DocumentType

%access public export
%default total

record DocumentType where
  constructor NewDocumentType
  name, publicId, systemId : String

