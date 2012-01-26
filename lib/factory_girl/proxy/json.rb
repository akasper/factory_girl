module FactoryGirl
  class Proxy
    class JSON < Hash
      def result(to_create)
        super.to_json
      end
    end
  end
end