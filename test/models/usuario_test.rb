require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'debe crear un usuario' do
  	u = Usuario.new(username: 'tamyg', email:'ta@g.com', password: '12345678')
  	assert u.save
  end

  test 'debe crear un usuario sin email' do
  	u = Usuario.new(username: 'tamyg', password: '12345678')
  	assert u.save
  end
end
