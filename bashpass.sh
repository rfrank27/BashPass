#!/bin/bash

. ./config.sh
addToVault() {
	
	echo "Ok. What's the password for $BASHPASS_HOME/$VAULT_NAME?"
	read pass

}
setup() {
	echo $BASHPASS_HOME
	if [ -d "$BASHPASS_HOME" ]; then
		echo "Found home!"	
	else
		echo "No home :(. Making one in $BASHPASS_HOME"
		mkdir $BASHPASS_HOME
		mkdir $BASHPASS_HOME/nodes
	fi
	if [ -f "$BASHPASS_HOME/$VAULT_NAME" ]; then
		echo "I found a vault!"
		echo "whats the password?"
		read pass
		openssl enc -aes-256-cbc -d -salt -in $BASHPASS_HOME/$VAULT_NAME -k $pass
		else
		echo "Oh no :o you dont have a vault"
		echo "let me make you one in $BASHPASS_HOME/$VAULT_NAME"
		touch $BASHPASS_HOME/tmpvault
		rm $BASHPASS_HOME/tmpvault
		echo "Now you need to choose a master password. I am going to use it to encrypt your vault with aes-256 encryption and then forget it. Do what you need to do to remember it and keep in mind that users are usually the weakest link in security :)"
		read masterpassword
		openssl enc -aes-256-cbc -salt -in $BASHPASS_HOME/tmpvault -out $BASHPASS_HOME/$VAULT_NAME -k $masterpassword
	fi
}

setup
