class LoginController < ActionController::API
    include Errors::DefaultHandler
    rescue_from Exception, :with => :render_error_response

    def login
        params.require([:email, :password])
        email = params[:email].strip.upcase
        plain_password = params[:password].strip
        user = User.find_by(email: email)
        data_res = do_login('admin', user, plain_password)

        respObj = Response::BaseResponse.new
        respObj.set_data(data_res)
        return render json: respObj.as_json, status: :ok
    end

    def login_ext
        params.require([:email, :password])
        email = params[:email].strip.upcase
        plain_password = params[:password].strip
        user = User.find_by(email: email)
        data_res = do_login('ext', user, plain_password)

        ActionLog.save_log(email, ActionLog::ACTION_TYPE[:login], {login_info: {request_ip: request.remote_ip}})
        respObj = Response::BaseResponse.new
        respObj.set_data(data_res)
        return render json: respObj.as_json, status: :ok
    end

    def change_password
        params.require([:email, :old_password, :new_password, :confirm_new_password])
        email = params[:email].strip.upcase
        user = User.find_by("password != '' AND email = ?", email)
        raise Errors::CustomException.new('社員が存在していません', 404, :not_found) if user.blank?
        
        old_password = BCrypt::Password.new(user.password)
        raise Errors::CustomException.new('パスワードが違います', 400, :bad_request) unless old_password == params[:old_password]
        raise Errors::CustomException.new('パスワードが一致していません', 400, :bad_request) unless params[:new_password] == params[:confirm_new_password]
        
        new_password = BCrypt::Password.create(params[:new_password])
        user.update!(password: new_password) 
        respObj = Response::BaseResponse.new
        respObj.set_msg('OK')
        return render json: respObj.as_json, status: :ok
    end

    private

    def do_login(login_type, user, plain_password)
        raise Errors::CustomException.new('社員が存在していません', 400, :bad_request) if user.blank?
        raise Errors::CustomException.new('Forbidden', 403, :forbidden) if user.password.blank?
        if login_type === 'admin' && ![User::ROLES[:admin], User::ROLES[:super_admin]].include?(user.role)
            raise Errors::CustomException.new('Forbidden', 403, :forbidden)
        end
        bcrypt_password = BCrypt::Password.new(user.password)
        raise Errors::CustomException.new('パスワードが違います', 400, :bad_request) unless bcrypt_password == plain_password
        token = JWT.encode({email: user.email, time: Time.now.to_i}, Rails.application.secrets['secret_key_base'], 'HS256')
        expired_date = Time.zone.now + Settings.token.expire_time.hours
        Token.find_or_initialize_by(token: token).update!(
            email:        user.email,
            expired_date:    expired_date,
            refresh_token:  ''
        )

        return {
            token: token,
            expired_date: expired_date.to_i,
            user_info: {
                email: user.email,
                role: user.role
            }
        }
    end
end