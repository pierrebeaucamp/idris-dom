module API.Web.DOM.Document

import API.Web.DOM.Node

%access public export
%default total

interface Node ty => Document ty where
  getElementById : ty -> String -> Ptr
