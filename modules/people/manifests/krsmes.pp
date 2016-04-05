class people::krsmes {

  notify { 'class people::krsmes declared': }

  include people::krsmes::config::osx
  include people::krsmes::config::gitconfig

}
