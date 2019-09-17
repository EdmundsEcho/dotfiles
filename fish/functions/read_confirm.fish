# A general helper function that records user input y/n
#
# Returns
#    0 when yes (true)
#    1 when no (false)
#
function read_confirm
  while true
    read -l -P 'Do you want to continue? [y/N] ' confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

