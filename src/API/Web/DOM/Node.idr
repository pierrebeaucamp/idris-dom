module API.Web.DOM.Node

import API.Web.DOM.Document
import API.Web.DOM.Element

%access public export
%default total

||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-node
data Node : Type where
  FromDocument : Document -> Node
  FromElement  : Element  -> Node

