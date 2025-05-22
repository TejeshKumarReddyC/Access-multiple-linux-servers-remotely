#!/bin/bash
servers="
10.155.128.219
10.155.128.48
10.155.128.42
10.155.128.37
10.155.128.72
10.155.128.45
10.155.128.57
10.155.128.29
10.155.128.30
10.155.128.40
10.155.128.52
10.155.128.70
10.155.128.51
10.155.128.33
10.155.128.47
10.155.128.46
10.155.128.71
10.155.128.75
10.155.128.44
10.155.128.36
10.155.128.32
10.155.128.43
10.159.128.54
10.159.128.34
10.159.128.41
10.159.128.52
10.159.128.48
10.159.128.42
10.159.128.60
10.159.128.39
10.159.128.53
10.159.128.44
10.159.128.37
10.159.128.33
10.159.128.49
10.159.128.55
10.159.128.57
10.159.128.56
10.159.128.35
10.159.128.50
10.159.128.38
10.159.128.40
10.159.128.59
10.159.128.43
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
		 

