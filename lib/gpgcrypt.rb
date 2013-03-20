require 'gibberish'
require 'pry'
require 'uri'
require 'open-uri'

require "gpgcrypt/version"

module GpgCrypt
  
  def self.encrypt_or_decrypt(*args)
    key_data = File.read(args[1]) #if File.exists
    key_type = get_key_type?(key_data)  # args[1] is either a public key or a private key...
    #binding.pry
    if File.exist? args[0]
      message_data = File.read(args[0])
    else
      message_data = args[0]
    end
    
    case key_type
    when :public
      encrypt(message_data, key_data)
    when :private
      decrypt(message_data, key_data)
    when :incompatible
      puts "The key entered was niether a public nor private key.  Check that you passed in a proper key as the second parameter."
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
    hlp += "To encrypt a message: \n  Supply a path to a file containing a message and an openSSL style public key. \n\n"
    hlp += "To decrypt a message: \n  Supply a path to a file containing an encrypted message and a private key.\n\n"
    hlp += "Soon you'll be able to export a public key from your private key and automatically pastebin it so others can message you.\n\n"
    hlp += "As an added feature, someday you will be able to specify pastebin links to encrypted messages and public keys"
  end
  
  
  # checks if a string is a path to a file or a URL
  # Returns a string of the file or URL page contents
  def self.path_to_content(string)
    string_is_a_file = File.exists? string
    string_is_a_uri = string =~ URI::regexp
    if string_is_a_file
      File.read(string)
    elsif string_is_a_uri
      URI.parse(string).read
    end
  end
  
  def scan_if_encrypted_message(string)
    return true if is_string_private_key?
    false
  end
  
  def self.convert_openssh_public_key_to_openssl(public_key_string)
    return public_key_string if true
    temp_file_path = '/tmp/gpgcrypt_pubtest'
    File.open(temp_file_path, "w+") do |f|
      f.puts public_key_string
    end
    
    openssl_key = `ssh-keygen -f #{temp_file_path}  -e -m pem`
    return openssl_key
  end
  
  def self.get_key_type?(string)
    key_type = :incompatible
    begin
      k = OpenSSL::PKey::RSA.new(string)
      if k.private?
        valid_private_key = :private
      elsif k.public?
        valid_private_key = :public
      else
        valid_private_key = :incompatible
      end
    rescue
      valid_private_key = :incompatible
    end
    valid_private_key
  end
  
end
