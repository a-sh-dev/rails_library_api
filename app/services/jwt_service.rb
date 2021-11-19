class JwtService
  @secret = Rails.application.credentials.dig(:secret_key_base)

  def self.encode(user)
    payload = { user_id: user.id, exp: 1.hour.from_now.to_i }
    token = JWT.encode(payload, @secret)
  end

  def self.decode(token)
    payload = JWT.decode(token, @secret, true)
    payload[0]
  rescue Exception => e
    pp e
    nil
  end
end
