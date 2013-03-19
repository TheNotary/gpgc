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
    
    public_key_string = convert_openssh_public_key_to_openssl(public_key_string)
    
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
  
  # This command let's you read your private key and generate from that
  # a suitable public key which will be posted to pastebin.  
  def self.export_public_key(private_key)
    raise "stub: not yet implemented"
  end
  
  def self.help
    hlp = "gpgcrypt allows you to 'manually' encrypt and decrypt messages over the command line.\n\n"
    hlp += "To Encrypt something, supply a string to a file containing your message and an openSSL style public key. \n\n"
    hlp += "To decrypt a message, supply a string to a file containing an encrypted message and a private key.\n\n"
    hlp += "Soon you'll be able to export a public key from your private key and automatically pastebin it so others can message you.\n\n"
    hlp += "As an added feature, someday you will be able to specify pastebin links to encrypted messages and public keys"
  end
  
  
  def scan_if_encrypted_message(string)
    true
  end
  
  def convert_openssh_public_key_to_openssl(public_key_string)
    public_key_string
  end
  
  
  
end
