module ApplicationHelper
	def get_email_oauth
		if session[:omniauth_data]
			session[:omniauth_data]['email']
		else
			"example@email.com"
		end
	end

	def get_username_oauth
		if session[:omniauth_data]
			session[:omniauth_data]['username']
		else
			""
		end
	end
end
