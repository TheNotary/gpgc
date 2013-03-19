require "gpgcrypt/version"

module Gpgcrypt
  
  def encrypt_or_decrypt(*args)
    code_should_be_encrypted = true
    
    scan_if_encrypted_message(args[0])
    
    if code_should_be_encrypted
      encrypt(*args)
    else
      decrypt(*args)
    end
  end
  
  def encrypt(*args)
    message_string = args[0]
    public_key = args[1]
    
    
  end
  
  def decrypt(*args)
    
  end
end
