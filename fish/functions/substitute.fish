# Next steps
# This is a dangerous and powerful function.
#
# 1. display the files that will be impacted by the change
# 2. ask the user for confirmation
# 3. quit or proceed accordingly
#
function substitute \
--argument find replace filetype ignore \
--description 'usage: substitute find replace filetype [ignore directory]'

    if test (count $argv) -lt 4 -o "argv[1]" = "--help"
      echo 'usage: substitute find replace filetype [ignore directory]'
      return 0
   end

   # preview which files will be impacted
   ggrep -rn  \
   --color=always  \
   --include=\*.$filetype  \
   --exclude-dir="$ignore"  \
   "$find" ./

   if read_confirm


     if set -q ignore

       find . -not -path $ignore \
       -type f -name "*.$filetype" \
       -exec gsed -i "s/$find/$replace/g" {} +

     else


       find . \
       -type f -name "*.$filetype" \
       -exec gsed -i "s/$find/$replace/g" {} +

     end
   end

end
