require 'spec_helper'



describe GpgCrypt do
  
  before :each do
    @ssh_pub_path = 'spec/dummy/ssh_pub_key'
    @pub_path = "spec/dummy/pub_key"
    @priv_path = "spec/dummy/priv_key"
    @msg_path = "spec/dummy/msg"
    
    @pub_key = "-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEAoxi2V0bSKqAqUtoQHxWkOPnErCS541r6/MOSHmKOd6VSNHoBbnas\nZRQSDUTbffB6C++DbmBCOHmvzYORD0ZWYgyMcgbYJD48Z2fe0nm+WMYN5u8DPnTP\nvf8b/rJBxGF0dsaoFAWlB81tTnKFCxAbCSgfmQt+Vd4qupGZ5gGu9uoKlaPjmYuA\nIxIjUMcu3dov7PQ+PZIvdkM0fiz8YIl8zo+iWWyI2s6/XLoZJ4bYs2YJHZDf6biU\nsZhs8xqh/F6qlcRt3Ta25KMa0TB9zE3HHmqA/EJHFubWFRCrQqpboB0+nwCbmZUl\nhaxA79FRvYtORvFAoncoFD4tq3rGXcUQQwIDAQAB\n-----END RSA PUBLIC KEY-----\n"
    @priv_key = "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAoxi2V0bSKqAqUtoQHxWkOPnErCS541r6/MOSHmKOd6VSNHoB\nbnasZRQSDUTbffB6C++DbmBCOHmvzYORD0ZWYgyMcgbYJD48Z2fe0nm+WMYN5u8D\nPnTPvf8b/rJBxGF0dsaoFAWlB81tTnKFCxAbCSgfmQt+Vd4qupGZ5gGu9uoKlaPj\nmYuAIxIjUMcu3dov7PQ+PZIvdkM0fiz8YIl8zo+iWWyI2s6/XLoZJ4bYs2YJHZDf\n6biUsZhs8xqh/F6qlcRt3Ta25KMa0TB9zE3HHmqA/EJHFubWFRCrQqpboB0+nwCb\nmZUlhaxA79FRvYtORvFAoncoFD4tq3rGXcUQQwIDAQABAoIBAEiF9p78mPvnWKqa\n2MxZvTqwpem+MwKMNEstU847GQrO8qzvC6/pCWOw9w37bnaj9kFUceck2o1uXuRN\n+rUGG+dhmRojPP1wxz9cCtMg26lx+ECWS6T8IFxmEjbBYUlH5JfkYlz03ZuIl3Bo\nsAxpTvxVYSeW2sioD+wCTqLeYMTeO6u8kPjNeuBp7ZKJ+xK/d91C9IycmxqXTiKC\n5Vpeh0i3xn0QvaHzttnvee0T8wQE6C7WAWlZsOZjuifOM77armuwLaL53KWdwV1H\nM/PSVyzhfFHzBvIixjJ/y6eA1e4XbwJk9M05XT5MGjYR1TL34a5UasRYKZz6jK4W\nHGyZxWECgYEA0Vf4BcYn65VgQI6Eff27j7ZJAFm6rGBvasWf+dye+Nkp1TjBhuPj\neAAOx72q+Ov0i+wN++Jsbh2CehFaWK0d7+mKmQdpbPXWwEicLs6oIO4zIhr+Y/q3\n2PaPlxwOrtazanfySVO4MklUTPEjvWGu+FKgGR5zd3fU1OArizP3iWkCgYEAx3Ih\nd9engWLxK4IwlJ4tiWKDqP7M4p2iGJckj/0Obgn2OgOHDhlFwLcTwA8iBuNlgU6N\nKqCCHvPm/8ycv3hp4etCPEEr3eeb46tO/MsZGtY0KZkCT61cHva1zWfxhdPs4oaP\n5qALRp8xfWJP8UHmzR+/QCQUJw1YM844EguVCssCgYBnkxeSe8T6iRBzQFALKgOn\nie+6baqvaJMXh6mr7Nz2kDNjXE5b19qOX7DwYEX8HHoE1Ijiq9cr8AvDK1zA7P4X\n2juJlSIzF7rlrccgXXzPtiq0YBinDL/zZ6IJiIc3N+DS9393iiVjM+aynsgpBfCU\nygSOCQPmAvLZVAQXPmHlqQKBgHT2583CeQeWIN1lMlxWD1p8nb3j///+det56AVR\nYL8DtJT9MJ0CETgdpcWCmm/zt7mHeZ5AF09TtmrZciuP0HifYW64waMXiwKPmnkC\nGqz0Zg7nHsXfYyD9ikz14lybllaal5Wm0jYOchWYLE3OWi59qclR30evucRX8eYT\nSMrVAoGAISImqYF376/pz/9TNEl5P8yOlIOG4grwzuykoBpFh98UCCiW/wzH5zCt\nMiy9hFH6Lgj9HGtsx/TvclgMBQtktBn5MrNarC8zWCAfIEaNQAkb6GrYXxrO2jnI\nOW7+BgxGQGFwtn+2TrJQOsgwFTZx1AmG53m3jhiO2HC2kd1VqgM=\n-----END RSA PRIVATE KEY-----\n"
    @ssh_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjGLZXRtIqoCpS2hAfFaQ4+cSsJLnjWvr8w5IeYo53pVI0egFudqxlFBINRNt98HoL74NuYEI4ea/Ng5EPRlZiDIxyBtgkPjxnZ97Seb5Yxg3m7wM+dM+9/xv+skHEYXR2xqgUBaUHzW1OcoULEBsJKB+ZC35V3iq6kZnmAa726gqVo+OZi4AjEiNQxy7d2i/s9D49ki92QzR+LPxgiXzOj6JZbIjazr9cuhknhtizZgkdkN/puJSxmGzzGqH8XqqVxG3dNrbkoxrRMH3MTcceaoD8QkcW5tYVEKtCqlugHT6fAJuZlSWFrEDv0VG9i05G8UCidygUPi2resZdxRBD"
    
    @unencrypted_message = 'hello world!' 
  end
  
  it "Should encrypt and decrypt a message based on a private key string" do
    enc = GpgCrypt.encrypt(@unencrypted_message, @pub_key)
    enc.should_not eq @unencrypted_message
    msg = GpgCrypt.decrypt(enc, @priv_key)
    msg.should eq @unencrypted_message
  end
  
  it "Should encrypt the contents of a file name passed in" do
    enc = GpgCrypt.encrypt_or_decrypt(@msg_path, @pub_path)
    GpgCrypt.encrypt_or_decrypt(enc, @priv_path).should eq File.read(@msg_path)
  end
  
  it "Should encrypt the first parameter passed in if it's not a file" do
    enc = GpgCrypt.encrypt_or_decrypt(@unencrypted_message, @pub_path)
    GpgCrypt.encrypt_or_decrypt(enc, @priv_path).should eq @unencrypted_message
  end
  
  # http://unix.stackexchange.com/questions/26924/how-do-i-convert-a-ssh-keygen-public-key-into-a-format-that-openssl-pem-read-bio
  # Usecase:  
  # You just generated a key pair via ssh-keygen.  
  #
  # You manually pastebin your public key so your partner can communicate with you.  
  # 
  # Your partner then wants to quickly encrypt a message by 
  #   $  gpgcrypt "hey, tell me if you can decrypt this" ~/.ssh/id_rsa.pub
  # 
  # This function will automatically convert the openSSH format into PEM
  #
  it "should convert ssh keys into openssl keys", :current => true do
    key = GpgCrypt.convert_openssh_public_key_to_openssl(@ssh_pub_key)
    key.should eq @pub_key
  end
  
  it "Should encrypt the file even if it's an ssh public key file that's supplied" do
    enc = GpgCrypt.encrypt_or_decrypt(@msg_path, @ssh_pub_path)
    GpgCrypt.encrypt_or_decrypt(enc, @priv_path).should eq File.read(@msg_path)
  end
  
  it "should be able to determine whether it should encrypt or decrypt something" do
    GpgCrypt.get_key_type?(@pub_key).should be :public
    GpgCrypt.get_key_type?(@priv_key).should be :private
    GpgCrypt.get_key_type?("@priv_key").should be :incompatible
  end
end