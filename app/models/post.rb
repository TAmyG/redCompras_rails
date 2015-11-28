class Post < ActiveRecord::Base
  #dependent destroy elimina todas las referencias en todos los
  #modelos relacionado
  belongs_to :usuario, dependent: :destroy
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true
  before_save :valores_por_default
  include Picturable
  include PublicActivity::Model
  	tracked owner: Proc.new{ |controller, model| controller.current_usuario }

#el || sirve para que rails asigne el valor si se crea el modelo sin dicho campo
  	def valores_por_default
  		self.costo ||= 0
  	end
end