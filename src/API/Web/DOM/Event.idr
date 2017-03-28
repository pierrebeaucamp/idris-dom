module API.Web.DOM.Event

%access public export
%default total

||| An Event is an object used for signaling that something has occured, e.g.,
||| that an image has completed downloading.
|||
||| The original interface specification can be found at
||| https://dom.spec.whatwg.org/#interface-event
record Event where
  constructor New
  ||| The type of *Event*, e.g. "`click`", "`hashchange`", or "`submit`"
  type : String
