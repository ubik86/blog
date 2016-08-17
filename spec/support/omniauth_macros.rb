module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    
    before :each do 
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '1084474418310513',
        info: {
          name: 'mockuser',
          image: 'mock_user_thumbnail_url',
          email: 'test@test.pl'
        },
        credentials: {
          token: '1084474418310513',
          secret: 'a0215ed74248f10c1fe489d6329e04d3'
        }
      })
    end
  end
end