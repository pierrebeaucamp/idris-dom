module API.Web.DOM.Node

import API.Web.DOM.EventTarget

%access public export
%default total

interface EventTarget ty => Node ty where
  contains : ty -> ty -> Bool
