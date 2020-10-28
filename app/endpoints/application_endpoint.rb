module ApplicationEndpoint
  class Protocol < Trailblazer::Endpoint::Protocol
    def authenticate(ctx, controller:, **)
      true
    end
  end

  class Adapter < Trailblazer::Endpoint::Adapter::API
    ### steps are declared in Trailblazer::Endpoint::Adapter and definations are here
    #
    # step :render_success
    # step :render_not_authenticated, magnetic_to: :not_authenticated
    # step :render_not_authorized, magnetic_to: :not_authorized
    # step :render_unprocessable_entity, magnetic_to: :invalid_data
    # step :render_not_found, magnetic_to: :not_found

    def render_success(ctx, controller:, domain_ctx:, **)
      controller.header 200
      controller.body(domain_ctx[:model])
    end

    def render_not_authenticated(ctx, controller:, **)
      controller.header 401
      controller.body({ my: :not_authenticated })
    end

    def render_not_authorized(ctx, controller:, **)
      controller.header 403
      controller.body({ my: :not_authorized })
    end

    def render_unprocessable_entity(ctx, controller:, **)
      controller.header 422
      controller.body({ my: :unprocessable_entity })
    end

    def render_not_found(ctx, controller:, **)
      controller.header 404
      controller.body({ my: :not_found })
    end
  end
end
