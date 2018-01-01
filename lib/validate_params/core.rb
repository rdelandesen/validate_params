class InvalidParamsException < Exception; end

class ValidateParams::Core
  OPTIONS = %i(type default size cast in range regex custom).freeze
  CAST_TYPES = %i(Integer Array Float).freeze

  class << self
    def validate!(params, args)
      new(params, args)
    end
  end

  def initialize(params, args)
    @params = params
    @args   = args

    proceed
  end

  private

  def proceed
    @args.each do |arg|
      case arg
      when Symbol
        validate_presence(arg)
      when Hash
        arg.each do |h|
          validate_hash(h)
        end
      end
    end
  end

  def validate_presence(key)
    _raise("#{key} is not present") unless @params[key].present?
  end

  def validate_hash(hash)
    key, value = hash

    case value
    when Class
      validate_class(key, value)
    when Hash
      validate_presence(key) unless value.keys.include? :default

      value.each do |opt_key, opt_value|
        validate_option(key, opt_key, opt_value)
      end
    end
  end

  def validate_class(key, klass)
    unless @params[key].is_a? klass
      _raise("#{key} is not a #{klass}")
    end
  end

  def validate_option(param, opt_key, opt_value)
    unless OPTIONS.include? opt_key
      raise TypeError.new("Option #{opt_key} is not valid")
    end

    case opt_key
    when :type
      validate_class(param, opt_value)
    when :default
      @params[param] = opt_value
    when :cast
      cast(param, opt_value)
    when :size
      unless @params[param].size == opt_value
        _raise("#{param} size is not equal to #{opt_value}")
      end
    when :range
      unless opt_value.include? @params[param].to_i
        _raise("#{param} is not included in #{opt_value}")
      end
    when :in
      unless opt_value.include? @params[param]
        _raise("#{param} is not included in #{opt_value}")
      end
    when :regex
      unless opt_value =~ @params[param]
        _raise("#{param} does not match with #{opt_value}")
      end
    when :custom
      unless opt_value.call @params[param]
        _raise("#{param} does not match with #{opt_value}")
      end
    end
  end

  def cast(param, type)
    unless CAST_TYPES.include? type
      raise TypeError.new("Cast type #{type} is not valid")
    end

    @types ||= {
      Integer: 0,
      Array: [],
      Float: 0.0
    }.freeze

    @params[param] = begin
                       self.send(type, @params[param])
                     rescue
                       @types[type]
                     end
  end

  def _raise(msg)
    raise InvalidParamsException.new msg
  end
end
