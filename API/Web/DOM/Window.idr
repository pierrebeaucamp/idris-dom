module API.Web.Window

import API.Web.DOM.Document

%access public export
%default total

record Window where
  constructor GetWindow
  document : Document ty
