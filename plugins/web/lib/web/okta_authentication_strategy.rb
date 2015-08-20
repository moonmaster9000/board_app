module Web
  class OktaAuthenticationStrategy
    def initialize(auth_hash:)
      @auth_hash = auth_hash
    end

    def execute(observer:)
      if (email.end_with?("pivotal.io"))
        observer.authentication_succeeded
      else
        observer.authentication_failed
      end
    end

    private

    def email
      info["email"] || ""
    end

    def info
      @auth_hash["info"] || {}
    end
  end
end
