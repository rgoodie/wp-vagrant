cd $HOME

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
wp --info



#WPCLI companion
curl -O http://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash

echo 'source ~/wp-completion.bash' >> ~/.bash_profile
