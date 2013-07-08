function fish_prompt --description 'Write out the prompt'
	set -l last_status $status

  # User
  set_color red
  echo -n (whoami)
  set_color normal

  echo -n '@'

  # Host
  set_color $fish_color_host
  echo -n (hostname -s)
  set_color normal

  echo -n ':'

  # PWD
  set_color magenta
  echo -n (prompt_pwd)
  set_color normal
  printf ':'
  set_color cyan
  printf '%s' (ls -1 | wc -l | sed "s: ::g")
  set_color normal

  printf '%s' (__fish_git_prompt)

  echo

  if test $VIRTUAL_ENV
    printf "(%s) " (set_color yellow)(basename $VIRTUAL_ENV)(set_color normal)
  end
  if not test $last_status -eq 0
    set_color $fish_color_error
  end


  printf '➤ '
  set_color normal
end
