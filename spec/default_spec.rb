require 'spec_helper'

describe 'cloud-dev::default' do
  let(:chef_run) do 
    run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    run.converge('cloud-dev::Default')
  end
  it 'installs dependecies' do
    expect(chef_run).to install_package('curl')
  end
end

