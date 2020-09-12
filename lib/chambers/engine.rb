module Chambers
  class Engine < ::Rails::Engine
    isolate_namespace Chambers
    require 'uuid'
    require 'uuid_validator'
    require 'jbuilder'
  end
end
