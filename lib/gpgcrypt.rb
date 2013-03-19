require 'gibberish'

require "gpgcrypt/version"

module Gpgcrypt
  
  def encrypt_or_decrypt(*args)
    code_should_be_encrypted = scan_if_encrypted_message(args[0])
    
    if code_should_be_encrypted
      encrypt(*args)
    else
      decrypt(*args)
    end
  end
  
  # string1 = message_string
  # string2 = private_key_string
  #
  def encrypt(*args)
    message_string = args[0]
    private_key_string = File.open(args[1]).read    # read the file specified as the key...
    
    priv_key = OpenSSL::PKey::RSA.new(private_key_string)  # parse the string into an RSA object
    
    # encrypt the message
    cipher = Gibberish::RSA.new(priv_key)
    encrypted_message = cipher.encrypt(message_string)
    encrypted_message
  end
  
  def decrypt(*args)
    message_string = args[0]
    public_key_string = File.open(args[1]).read    # read the file specified as the key...
    
    pub_key  = OpenSSL::PKey::RSA.new(public_key_string)  # parse the string into an RSA key object
    
    # decrypt the message
    dec_cipher = Gibberish::RSA.new(pub_key)
    decrypted_message = dec_cipher.decrypt(message_string)
  end
  
  
  def scan_if_encrypted_message(string)
    return true
  end
end
