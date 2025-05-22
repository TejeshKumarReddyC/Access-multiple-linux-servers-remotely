#!/bin/bash
servers="
10.218.192.34
10.218.192.33
"
user="decomuser"
password="n0twest+Decom!inux"
script_file="acsv.sh"
output_file="ou.txt"
rm NF comb*

echo "" > "$output_file"
for server in $servers; do
 # echo "" > "$output_file"
  yes | sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$script_file" "$user@$server":/home/$user/
  if [ $? -ne 0 ]
  then
          echo "ERROR"
          echo "$server" >> NF
          continue
  fi
  #yes | sshpass -p "$password" ssh -o StrictHostKeyChecking=no "$user@$server" "sudo bash $script_file >>$output_file"
  yes | sshpass -p "$password" ssh -t -t -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$user@$server" "sudo -S bash $script_file >>$output_file"

  yes | sshpass -p "$password" scp -r -o StrictHostKeyChecking=no -o HostKeyAlgorithms=rsa-sha2-512 "$user@$server":/home/$user/"$output_file" "a${server}_$output_file"
  echo "done for $server"
done

cat *_$output_file > "combined_$output_file"
rm $output_file
