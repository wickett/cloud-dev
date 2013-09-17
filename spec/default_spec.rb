require 'spec_helper'

describe 'cloud-dev::default' do
  let(:chef_run) do 
    run = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04')
    run.converge('cloud-dev::default')
  end
end

