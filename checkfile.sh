echo "Which file do you want to check?"

read filename

until [ -e $filename ]

  do 

    echo "The file does not exist. Do you want to create it ? y/n"

    read choice

      if [ $choice = y ]; then  

         touch $filename

         echo "Your file has been created successfully."

      fi

  done

  echo "The file is present in this directory"

exit 0
