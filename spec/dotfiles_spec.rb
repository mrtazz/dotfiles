require 'pathname'

describe "symlinks" do
  [
    "#{ENV['HOME']}/.batrc",
    "#{ENV['HOME']}/.dotoverrides",
    "#{ENV['HOME']}/.gitconfig",
    "#{ENV['HOME']}/.gitignore",
    "#{ENV['HOME']}/.mutt",
    "#{ENV['HOME']}/.mutt",
    "#{ENV['HOME']}/.phoenix.js",
    "#{ENV['HOME']}/.ripgreprc",
    "#{ENV['HOME']}/.sqliterc",
    "#{ENV['HOME']}/.ssh/config",
    "#{ENV['HOME']}/.ssh/rc",
    "#{ENV['HOME']}/.tmux.conf",
    "#{ENV['HOME']}/.vim",
    "#{ENV['HOME']}/.vimrc",
    "#{ENV['HOME']}/.zlogin",
    "#{ENV['HOME']}/.zsh",
    "#{ENV['HOME']}/.zsh",
    "#{ENV['HOME']}/.zshrc",
    "#{ENV['HOME']}/bin"
  ].each do |link|
    context link do
      it "is a symlink" do
        expect(Pathname.new(link).symlink?).to be true
      end
    end
  end
end

describe "directories" do
  [
    "#{ENV['HOME']}/.ssh",
  ].each do |dir|
    describe dir do
      it "is a directory" do
        expect(Pathname.new(dir).directory?).to be true
      end
    end
  end
end

describe "files" do
  [
    "#{ENV['HOME']}/.ssh/authorized_keys",
  ].each do |file|
    describe file do
      it "is a file" do
        expect(Pathname.new(file).file?).to be true
      end
    end
  end
end
