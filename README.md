# Gpgcrypt

This gem is designed to allow you to manually encrypt/ decrypt RSA encoded messages using GnuPG.   

## Installation

Install the gem:

    $ gem install gpgcrypt

## Usage Template
Encrypting:

    $ gpgcrypt message public_key

Decrypting:

    $ gpgcrypt encrypted_message private_key

## Usage

Have your partner generate a public/private key pair (You may have already done this).  

    $ ssh-keygen -t rsa

Obtain a copy of your partner's public key.  

And then use gpgcrypt to encrypt a message using your partner's public key:

    $ gpgcrypt message.txt public_key_of_recipient_rsa.pub > encrypted_message.txt

Or have your partner decrypt a message of yours using your own private key:

    $ gpgcrypt encrypted_message.txt your_private_key_rsa > message.txt


## Alternate Usage

You can alternatively specify a URL to public keys or messages

Encrypting:

    $ gpgcrypt message.txt github.com/TheNotary/pgp/raw
    Your message has been pastebin'd to http://pastebin.com/lkajds;lkfjsdaf
    
Decrypting:

    $ gpgcrypt http://pastebin.com/lkajds;lkfjsdaf ~/.ssh/id_rsa
    
    

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
