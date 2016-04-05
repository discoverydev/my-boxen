require 'spec_helper'

describe 'osx::finder::show_mounted_servers_on_desktop' do
  let(:facts) { {:boxen_user => 'ilikebees'} }

  it do
    should include_class('osx::finder')

    should contain_boxen__osx_defaults('Show mounted servers on the desktop').with({
      :key    => 'ShowMountedServersOnDesktop',
      :domain => 'com.apple.finder',
      :value  => true,
      :notify => 'Exec[killall Finder]',
      :user   => facts[:boxen_user]
    })
  end
end
