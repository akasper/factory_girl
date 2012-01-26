module FactoryGirl
  class Proxy
    class Hash < Proxy
      def self.by_name(sym, factory=nil)
        self.new(sym, factory)
      end
      def initialize(klass, factory=nil)
        # I need the factory here so I can use the build blocks 
        # to mutate the hash's fields...
        @hash = MutableHash.new(factory)
      end
      def get(attribute)
        @hash[attribute]
      end
      def set(attribute, value)
        @hash[attribute] = value
      end
      def associate(name, factory_name, overrides={})
        factory = FactoryGirl.factory_by_name(factory_name)
        set(name, factory.run(Proxy::Hash, overrides))
      end
      def association(factory_name, overrides = {})
        factory = FactoryGirl.factory_by_name(factory_name)
        factory.run(Proxy::Hash, overrides)
        # associate(factory_name, factory_name, overrides)
      end
      def result(to_create)
        @hash
      end
    end
  end
end