require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "debe poder crear un post" do
  	post = Post.create(titulo: 'mi titulo', contenido: 'contenido')
  	assert post.save
  end

  test 'debe poder actualizar un post' do
  	 post = posts(:primer_articulo)
  	 assert post.update(titulo: 'up_titulo', contenido: 'up_contenido')
  end

  test 'debe encontrar un post por su id'  do
  	post_id = posts(:primer_articulo).id
  	post = Post.find(post_id)
  	assert_nothing_raised {Post.find(post_id)}
  	#assert_equal post, posts(:primer_articulo), 'No encontró el registro'
  end

  test 'debe borrar un post' do
  	post = posts(:primer_articulo)
  	post.destroy
  	assert_raise(ActiveRecord::RecordNotFound) {Post.find(post.id)}
  end

  test 'no debe crear un post sin titulo' do
  	post = Post.new
  	assert post.invalid?, 'post invalido'
  end

  test 'cada tiulo debe ser único' do
  	post = Post.new
  	post.titulo = posts(:primer_articulo).titulo
  	assert post.invalid?, 'Dos posts no deben tener el mismo título'
  end
end