module Twitter
  class Api < Grape::API
    format :json

    # helpers Trailblazer::Endpoint::Controller

    extend Trailblazer::Endpoint::Controller
    helpers Trailblazer::Endpoint::Controller::InstanceMethods, Trailblazer::Endpoint::Controller::InstanceMethods::API

=begin
    `-- #<Class:0x00007fdc24a7b2e8>
        |-- Start.default
        |-- #<Class:0x00007fdc24a9a8f0>
        |   |-- Start.default
        |   |-- authenticate
        |   |-- Twitter::Operation::Feed
        |   |   |-- Start.default
        |   |   |-- authorize
        |   |   |-- model
        |   |   |-- load_json
        |   |   `-- End.success
        |   `-- End.success
        |-- render_success
        `-- End.success
=end

    endpoint Twitter::Operation::Feed, protocol: ::ApplicationEndpoint::Protocol, adapter: ::ApplicationEndpoint::Adapter
    get "/" do
      endpoint Twitter::Operation::Feed, config_source: Twitter::Api # TODO: Make config_source optional
    end

=begin
    `-- #<Class:0x00007f8d86371ae8>
    |-- Start.default
    |-- #<Class:0x00007f8d86390d30>
    |   |-- Start.default
    |   |-- authenticate
    |   |-- Twitter::Operation::Feed
    |   |   |-- Start.default
    |   |   |-- authorize
    |   |   |-- model
    |   |   |-- load_json
    |   |   `-- End.failure
    |   `-- End.invalid_data
    |-- render_unprocessable_entity
    `-- End.success
=end

    resources :feed do
      extend Trailblazer::Endpoint::Controller

      # using `track(:semantic) do .. end` for overriding any adapter step
      endpoint(Twitter::Operation::Feed, protocol: ::ApplicationEndpoint::Protocol, adapter: ::ApplicationEndpoint::Adapter).
        track(:not_found) do |ctx, controller:, **|
          controller.status 404
          controller.body({ msg: :overridden_not_found })
        end.track(:not_authorized) do |ctx, controller:, **|
          controller.status 403
          controller.body({ msg: :overridden_not_authorized })
        end

      get { endpoint Twitter::Operation::Feed, config_source: Twitter::Api }
    end
  end
end
