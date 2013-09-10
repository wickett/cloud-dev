require 'spec_helper'

describe 'gary::default' do
  let(:chef_run) do 
    run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    run.converge('gary::Default')
  end
  it 'installs dependecies' do
    expect(chef_run).to install_package('curl')
  end
end

