require 'spec_helper'

describe 'cloud-dev::default' do
  let(:chef_run) do 
    run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    run.converge('cloud-dev::default')
  end
  it 'installs dev packages like libxsl, libcurl, ...' do
    expect(chef_run).to install_package('devpkg')
  end
end

