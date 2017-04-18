#!/usr/bin/env ruby

BUNDLES=%w(
  https://github.com/junegunn/fzf.vim
  https://github.com/leafgarland/typescript-vim.git
  https://github.com/mbbill/undotree
  https://github.com/mileszs/ack.vim
  https://github.com/scrooloose/nerdtree
)

Dir.chdir(File.dirname(__FILE__))

BUNDLES.each do |b|
  dirname = b
    .sub(/^.*\//, '')
    .sub(/\.git$/, '')

  if File.directory? dirname
    Dir.chdir dirname do
      system('git', 'up')
    end
  else
    system('git', 'clone', b) # FIXME die on fail
  end
end
