module API.Web.DOM.EventTarget

%access public export
%default total

interface EventTarget target where
  addEventListener : target -> JS_IO ()
