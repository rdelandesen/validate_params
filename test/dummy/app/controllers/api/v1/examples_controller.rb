class Api::V1::ExamplesController < ApplicationController
  include ValidateParams

  def create
    params[:type] ||= 1
    self.send("_#{params[:type]}")
    render json: { example: params[:example] }
  end

  private

  def _presence
    validate_params! :example
  end

  def _presence_2
    validate_params! :example, :example2
  end

  def _type
    validate_params! example: Array
  end

  def _type_2
    validate_params! example: { type: Array }
  end

  def _types
    validate_params! example: Array, example2: String
  end

  def _type_and_size
    validate_params! example: { type: Array, size: 2 }
  end

  def _range
    validate_params! example: { range: 0..10 }
  end

  def _regex
    validate_params! example: { regex: /myregex/ }
  end

  def _proc
    validate_params! example: { custom: Proc.new { |value| value == 'a' } }
  end

  def _default
    validate_params! example: { default: 'abc' }
  end

  def _in
    validate_params! example: { in: %w(test1 test2) }
  end

  def _cast
    validate_params! example: { cast: :Integer }
  end
end
