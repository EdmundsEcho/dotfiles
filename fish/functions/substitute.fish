# Next steps
# This is a dangerous and powerful function.
#
# 1. display the files that will be impacted by the change
# 2. ask the user for confirmation
# 3. quit or proceed accordingly
#
# function NAME [OPTIONS]; BODY; end
#
# There are two user input states
# * stored in the flag variables (see argparse)
# * stored in argv
#
function substitute \
--description 'usage: substitute find replace filetype [--go] [--ignore=directory]'

  # ---------------------------------------------------------------------------
  set -l options (fish_opt --short=h --long=help)
  set options $options (fish_opt --short=g --long=go)
  set options $options (fish_opt --short=i --long=ignore --multiple-vals)

  # ---------------------------------------------------------------------------
  # set options to local scope
  # ---------------------------------------------------------------------------
  argparse $options -- $argv

  # validate user input
  if test (count $argv) -lt 3
      echo 'usage: substitute find replace filetype [--go] [--ignore=directory]'
      return 0
  end

  # ---------------------------------------------------------------------------
  # preview which files will be impacted
  # ---------------------------------------------------------------------------
  set -l args "-rn --color=always"
  set -a args "--include=\"*.$argv[3]\""

  if test (count $_flag_ignore) -gt 0
    for ignore in $_flag_ignore
      set -a args "--exclude-dir=\"$ignore\""
    end
  end
  set -a args "\"\b$argv[1]\b\" ./"

  eval ggrep $args

  # ---------------------------------------------------------------------------
  # actually run substitute
  # ---------------------------------------------------------------------------
  if test -n "$_flag_go"

    echo "Be sure to preview the substitutions by excluding the --go flag"

    if read_confirm

      set -l args "."

      # include optional ignore
      if test (count $_flag_ignore) -gt 0
        for ignore in $_flag_ignore
          set -a args "-not -path \"$ignore\""
        end
      end
      set -a args "-type f -name \"*.$argv[3]\""
      set -a args "-exec gsed -i \"s/\b$argv[1]\b/$argv[2]/g\" {} +"

      eval find $args
      echo "completed the substitution"
      return 0
    else
      echo "cancelled"
      return 0
    end
  # ---------------------------------------------------------------------------
  else
    echo "done"
    return 0
  end
end
