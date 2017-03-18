module API.Web.DOM.EventTarget

%access public export
%default total

interface EventTarget ty where
  addEventListener : ty -> ()
