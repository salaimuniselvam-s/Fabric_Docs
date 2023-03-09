if [ -z $1 ];
then
    echo 'No Command Line Argument is Passed  While Running the Script'
    exit 0;
else
   echo $1 ' is Passed as Argument While Running the Script'
fi

# ./runningScript 2> /dev/null -> if any error throws does not show in the terminal

# if [[ $0 = *"env.sh" ]] -> if[[expression validation]]


pgrep -> pgrep looks through the currently running processes and lists the process IDs which match the selection criteria to stdout
  eg: -x --> exact flag
      pgrep -help