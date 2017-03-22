module API.Web.DOM.XMLDocument

import API.Web.DOM.Node
import IdrisScript

%access public export
%default total

interface Node document => XMLDocument document where
  getElementById : document -> String -> JSRef

