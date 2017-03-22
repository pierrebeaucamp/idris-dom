module API.Web.DOM.HTMLDocument

import API.Web.DOM.DocumentType
import API.Web.DOM.EventTarget
import API.Web.DOM.Node
import API.Web.DOM.XMLDocument
import IdrisScript

%access public export
%default total

interface XMLDocument document => HTMLDocument document where
  hasFocus : document -> Bool

record Document where
  constructor NewDocument

EventTarget Document where
  addEventListener doc = ?rhs

Node Document where
  contains doc = ?rhs

XMLDocument Document where
  getElementById doc = ?rhs

HTMLDocument Document where
  hasFocus doc = ?rhs
