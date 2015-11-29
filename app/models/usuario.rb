class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :posts
  has_many :friendships, foreign_key: 'usuario_id', dependent: :destroy
  has_many :follows, through: :friendships, source: :friend
  has_many :followers_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :followers, through: :followers_friendships, source: :usuario
  has_many :payments

#agregar amigos a mi mismo
  def follow!(amigo_id)
    self.friendships.create!(friend_id: amigo_id)
  end

  def can_follow?(amigo_id)
    #id es igual a self.id
    not amigo_id == id or friendships.where(friend_id: amigo_id).size > 0
  end

  #sobre escribir validatable
  def email_required?
    false
  end

  def costo_compra_pendiente
    payments.where(estado: 1).joins('INNER JOIN posts on posts.id == payments.post_id').sum('costo')

  end

  validates :username, presence: true, uniqueness: true, 
  length: {in: 5..20, too_short: 'Tiene que tener al menos 5 chars',too_long: 'El máximo es de 20 chars'},
  format: {with: /([A-Za-z0-9\-\_]+)/, message: 'username solo puede tener letras, números y guiones'}

  #validate :validacion_personalizada, on: :create

#método para buscar o agreagar a un usuario que se loguea con
#su red social
#el password simplemente se crea con una combinación de devise
#para no dejarla vacía
  def self.find_or_create_by_omniauth(auth)
  	usuario = Usuario.where(provider: auth[:provider], uid: auth[:uid]).first
  	
  	unless usuario
  		usuario = Usuario.create(
  			nombre: auth[:nombre],
  			apellido: auth[:apellido],
  			email: auth[:email],
  			username: auth[:username],
  			uid: auth[:uid],
  			provider: auth[:provider],
  			password: Devise.friendly_token[0,20]
  		)  		
  	end  	
  	usuario
  end

  private

  #def validacion_personalizada
  #  if true
  #  else
  #    errors.add(:username, 'Tu username no es válido')
  #  end
  #end

end
