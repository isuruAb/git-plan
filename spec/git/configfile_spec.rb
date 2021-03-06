require 'spec_helper'

describe Git::Plan::ConfigFile do
  describe 'Cli integration' do
    let(:ccfile) { Git::Plan::ConfigFile.instance }

    it 'ConfigFile load the local file' do
      expect(ccfile).not_to be nil
    end

    it 'ConfigFile add commands to localfile' do
      hash = {"status" => "git status, git log"}
      ccfile.add_command hash

      file = YAML.load_file(ccfile.path)
      status_command = file['commands']['status']
      expect(status_command).to eq "git status, git log"
    end

    it 'ConfigFile run the command from the localfile' do
      hash = {"status" => "git status, git log"}
      ccfile.add_command hash

      command = ccfile.run "status"
      expect(command).to eq "git status, git log"
    end

    it 'write method in ConfigFile is private' do
      expect{ccfile.write}.to raise_error(NoMethodError)
    end

    it 'default_structure method in ConfigFile is private' do
      expect{ccfile.default_structure}.to raise_error(NoMethodError)
    end

  end
end
