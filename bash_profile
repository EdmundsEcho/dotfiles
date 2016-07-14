# Addition for Haskell (July 12, 2015)
PATH="/Users/edmundcape/Library/Haskell/bin:${PATH}"

# Addition Feb 8, 2016
PATH="/usr/local/bin:${PATH}"

# Setting PATH for Hugs
PATH="/opt/local/bin:${PATH}"
export PATH

# Apr 30th, 2016 to show \n
shopt -s xpg_echo

# Jul 12th, 2016
bat() {
 ioreg -l |awk 'BEGIN{FS="=";max=0;cur=0;}
 $1~/CurrentCapacity/{cur=$2} 
 $1~/MaxCapacity/{max=$2}
 END{if (max>0) {printf "%.2f%%\n",cur/max*100} else {print "?"}}'
}
