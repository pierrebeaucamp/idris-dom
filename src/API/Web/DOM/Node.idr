module API.Web.DOM.Node

import API.Web.DOM.EventTarget

%access public export
%default total

interface EventTarget node => Node node where
  contains : node -> node -> Bool
