module OmniauthMacros
  def mock_auth(provider, email)
    email = email[0] if email.class == Hash

    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      'provider' => provider.to_s,
      'uid' => '654321',
      'info' => { 'email' => email }
    })
  end
end
