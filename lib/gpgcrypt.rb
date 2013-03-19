require 'gibberish'
require 'pry'

require "gpgcrypt/version"

module GpgCrypt
  
  def self.encrypt_or_decrypt(*args)
    code_should_be_encrypted = scan_if_encrypted_message(args[0])
    
    if code_should_be_encrypted
      encrypt(*args)
    else
      decrypt(*args)
    end
  end
  
  # @param [string] message
  #
  # @param [string] public_key
  #
  # @return [string] encrypted
  #
  def self.encrypt(message, public_key)
    message_string = message
    public_key_string = public_key
    
    # encrypt the message
    cipher = Gibberish::RSA.new(public_key_string)
    encrypted_message = cipher.encrypt(message_string)
  end
  
  # @param [string] message
  #
  # @param [string] public_key
  #
  # @return [string] encrypted
  #
  def self.decrypt(encrypted_message, private_key)
    message_string = encrypted_message
    private_key_string = private_key
    
    # decrypt the message
    dec_cipher = Gibberish::RSA.new(private_key_string)
    decrypted_message = dec_cipher.decrypt(message_string)
  end
  
  
  def scan_if_encrypted_message(string)
    true
  end
  
end
