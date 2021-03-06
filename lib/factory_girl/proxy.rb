module FactoryGirl
  class Proxy #:nodoc:

    attr_reader :callbacks

    def self.by_name(name, factory=nil)
      self.new(build_class(name))
    end
    def self.build_class(class_or_to_s)
      if class_or_to_s.respond_to?(:to_sym)
        class_name = variable_name_to_class_name(class_or_to_s)
        class_name.split('::').inject(Object) do |object, string|
          object.const_get(string)
        end
      else
        class_or_to_s
      end
    end
    def self.variable_name_to_class_name(name)
      name.to_s.
        gsub(/\/(.?)/) { "::#{$1.upcase}" }.
        gsub(/(?:^|_)(.)/) { $1.upcase }
    end

    def initialize(klass)
    end

    def get(attribute)
      nil
    end

    def set(attribute, value)
    end

    def associate(name, factory, attributes)
    end

    def add_callback(name, block)
      @callbacks ||= {}
      @callbacks[name] ||= []
      @callbacks[name] << block
    end

    def run_callbacks(name)
      if @callbacks && @callbacks[name]
        @callbacks[name].each do |block|
          block.arity.zero? ? block.call : block.call(@instance)
        end
      end
    end

    # Generates an association using the current build strategy.
    #
    # Arguments:
    #   name: (Symbol)
    #     The name of the factory that should be used to generate this
    #     association.
    #   attributes: (Hash)
    #     A hash of attributes that should be overridden for this association.
    #
    # Returns:
    #   The generated association for the current build strategy. Note that
    #   associations are not generated for the attributes_for strategy. Returns
    #   nil in this case.
    #
    # Example:
    #
    #   factory :user do
    #     # ...
    #   end
    #
    #   factory :post do
    #     # ...
    #     author { |post| post.association(:user, :name => 'Joe') }
    #   end
    #
    #   # Builds (but doesn't save) a Post and a User
    #   FactoryGirl.build(:post)
    #
    #   # Builds and saves a User, builds a Post, assigns the User to the
    #   # author association, and saves the User.
    #   FactoryGirl.create(:post)
    #
    def association(name, overrides = {})
      nil
    end

    def method_missing(method, *args, &block)
      get(method)
    end

    def result(to_create)
      raise NotImplementedError, "Strategies must return a result"
    end
  end
end
