#!/bin/bash
servers="
10.155.128.219
10.155.128.48
"
rm notdone
username="decomuser"
password="n0twest+Decom!inux"
ssh_options="-o StrictHostKeyChecking=no"
for server in $servers; do
	  #echo "$server"
	   # sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "df -Th | grep nfs;sudo  sed -i '/nfs/s/^/#/' /etc/fstab;sudo  service besclient stop;sudo  systemctl disable besclient"
  #sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "netstat"
  #sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo df -Th"
  if [[ $? -ne 0 ]]
  then
	  echo "ERROR"
	  echo "$server" >> notdone
	  continue
  fi


	      sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo sed -i '/nfs/s/^/#/' /etc/fstab"
	       sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo service besclient stop"
		 sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo umount -a -l -t nfs"
    sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo systemctl disable besclient"
		 sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo chkconfig besclient off"
		  sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo service rsyslog stop" 
	       if [[ $? -ne 0 ]]
	       then
	          echo "ERROR"
                  echo "$server" >> notdone
                  continue
              fi	  
		  sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo systemctl stop rsyslog"
	     sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo systemctl disable rsyslog"
               sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo chkconfig rsyslog off"
	sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$username@$server" "sudo chkconfig besclient off"
 sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$username@$server" "sudo shutdown -h now " &
	           echo "done for $server"

	 done
		 

