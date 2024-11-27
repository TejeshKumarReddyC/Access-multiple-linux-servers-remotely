#!/bin/bash
servers="
10.159.12.1
"
user="decomuser"
password="n0twest+Decom!inux"
script_file="acsv.sh"
output_file="ou.txt"

echo "" > "$output_file"
for server in $servers; do
 # echo "" > "$output_file"
  yes | sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$script_file" "$user@$server":/home/$user/
  if [ $? -ne 0 ]
  then
	  echo "ERROR"
	  echo "$server" >> NF
	  continue
  fi
  #yes | sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$user@$server" "sudo bash $script_file >>$output_file"
  yes | sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa  "$user@$server" "sudo -S bash $script_file >>$output_file"
  yes | sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -o HostKeyAlgorithms=ssh-rsa "$user@$server":/home/$user/"$output_file" "${server}_$output_file"
  echo "done for $server"
done

cat *_$output_file > "combined_$output_file"
rm $output_file


