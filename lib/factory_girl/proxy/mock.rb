module FactoryGirl
  class Proxy
    class Mock < Proxy
      def self.by_name(sym, factory=nil)
        self.new(sym, factory)
      end
      def initialize(klass, factory=nil)
        @mock = RSpec::Mocks::Mock.new(klass)
        if factory && factory.class_name.is_a?(Class)
          @mock.stub(:class).and_return(factory.class_name)
          factory.class_name.stub(:===).with(@mock).and_return(true)
          @mock.stub(:===).with(factory.class_name).and_return(true)
          @mock.stub(:is_a?).with(factory.class_name).and_return(true)
          @mock.stub(:kind_of?).with(factory.class_name).and_return(true)
          @mock.stub(:instance_of?).with(factory.class_name).and_return(true)
        end
      end
      def get(attribute)
        @mock.send(attribute)
      end
      def set(attribute, value)
        @mock.stub(attribute.to_sym).and_return(value)
      end
      def associate(name, factory_name, overrides={})
        factory = FactoryGirl.factory_by_name(factory_name)
        set(name, factory.run(Proxy::Mock, overrides))
      end
      def association(factory_name, overrides = {})
        factory = FactoryGirl.factory_by_name(factory_name)
        factory.run(Proxy::Mock, overrides)
      end
      def result(to_create)
        @mock
      end
    end #Mock
  end
end