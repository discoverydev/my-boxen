require 'spec_helper'

describe 'jenkins::plugin' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen',
      :boxen_user => 'testuser',
    }
  end

  let(:title) { 'notification' }
  let(:params) { { :version => '1.4' } }

  it do
    should contain_class('jenkins::config')
  end
end
