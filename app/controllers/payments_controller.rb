class PaymentsController < ApplicationController
	#helper de devise
	before_action :authenticate_usuario!

	def create
		@payment = current_usuario.payments.new(post_params)
		respond_to do |format|
			if @payment.save
				format.html{ redirect_to carrito_path }
				format.json {head :no_content}
			else
				redirect_to Post.find(post_params[:post_id]), error: 'No se pudo procesar tu compra'
				format.json {head :no_content}
			end
		end
	end

	def carrito
		@payments = current_usuario.payments.where(estado: 1)
	end

	private
	def post_params
		params.require(:payment).permit(:post_id)
	end
end
