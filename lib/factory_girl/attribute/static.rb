module FactoryGirl
  class Attribute #:nodoc:

    class Static < Attribute  #:nodoc:

      def initialize(name, value)
        super(name)
        @value = value
      end

      def add_to(proxy)
        proxy.set(name, @value)
      end

      def priority
        0
      end
      
      def mutate
        raise AttributeMutationException.new("Cannot mutate a Static attribute.")
      end

    end
  end
end
