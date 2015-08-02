module Web
  class OktaAuthenticationStrategy
    def initialize(auth_hash:)
      @auth_hash = auth_hash
    end

    def execute(observer:)
      observer.authentication_succeeded
    end
  end
end
