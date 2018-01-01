require 'test_helper'

class Api::V1::ExamplesControllerTest < ActionController::TestCase
  ##
  # Presence validation
  #
  test 'presence validation with good values' do
    post(:create, type: :presence, example: true)
    assert_response :success
  end

  test 'presence validation with bad values' do
    post(:create, type: :presence)
    assert_response 400
  end

  test 'presence validation with good values (2)' do
    post(:create, type: :presence_2, example: true, example2: true)
    assert_response :success
  end

  test 'presence validation with bad values (2)' do
    post(:create, type: :presence_2, example: true)
    assert_response 400
  end

  test 'presence validation with good values (2) (b)' do
    post(:create, type: :presence_2, example2: true)
    assert_response 400
  end

  ##
  # Type validation
  #
  test 'type validation with good values' do
    post(:create, type: :type, example: [1])
    assert_response :success
  end

  test 'type validation with bad values' do
    post(:create, type: :type, example: true)
    assert_response 400
  end

  test 'type validation with good values (2)' do
    post(:create, type: :type_2, example: [1])
    assert_response :success
  end

  test 'type validation with bad values (2)' do
    post(:create, type: :type_2, example: true)
    assert_response 400
  end

  test 'types validation with good values' do
    post(:create, type: :types, example: [1], example2: 'abc')
    assert_response :success
  end

  test 'types validation with bad values' do
    post(:create, type: :types, example: true, example2: 'abc')
    assert_response 400
  end

  test 'types validation with bad values (b)' do
    post(:create, type: :types, example: [1], example2: [1])
    assert_response 400
  end

  test 'types validation with bad values (c)' do
    post(:create, type: :types, example: 'abc', example2: 'abc')
    assert_response 400
  end

  ##
  # Type (Array) and size (2) validations
  #
  test 'type and size validations with good values' do
    post(:create, type: :type_and_size, example: [1, 2])
    assert_response :success
  end

  test 'type and size validations with bad values' do
    post(:create, type: :type_and_size, example: [1])
    assert_response 400
  end

  ##
  # Range (0..10) validation
  #
  test 'range validation with good values' do
    post(:create, type: :range, example: 5)
    assert_response :success
  end

  test 'range validation with bad values' do
    post(:create, type: :range, example: 11)
    assert_response 400
  end

  ##
  # Regex (/myregex/) validation
  #
  test 'regex validation with good values' do
    post(:create, type: :regex, example: 'myregex')
    assert_response :success
  end

  test 'regex validation with bad values' do
    post(:create, type: :regex, example: 'nop')
    assert_response 400
  end

  ##
  # Proc (value == 'a') validation
  #
  test 'proc validation with good values' do
    post(:create, type: :proc, example: 'a')
    assert_response :success
  end

  test 'proc validation with bad values' do
    post(:create, type: :proc, example: 'b')
    assert_response 400
  end

  ##
  # Default value 'abc'
  #
  test 'default setter' do
    post(:create, type: :default)
    assert_response :success

    body = JSON.parse(@response.body)
    assert_equal 'abc', body['example']
  end

  ##
  # In (test1 test2) validation
  #
  test 'in validation with good values' do
    post(:create, type: :in, example: 'test1')
    assert_response :success
  end

  test 'in validation with bad values' do
    post(:create, type: :in, example: 'test3')
    assert_response 400
  end

  ##
  # Cast validation
  #
  test 'cast validation' do
    post(:create, type: :cast, example: '100')
    assert_response :success

    body = JSON.parse(@response.body)
    assert_equal 100, body['example']
  end
end
