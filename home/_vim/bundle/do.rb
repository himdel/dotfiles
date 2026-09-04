#!/usr/bin/env ruby

BUNDLES=%w(
  https://github.com/preservim/nerdtree
  https://github.com/Xuyuanp/nerdtree-git-plugin
  https://github.com/junegunn/fzf
  https://github.com/junegunn/fzf.vim
  https://github.com/mbbill/undotree
)

Dir.chdir(File.dirname(__FILE__))

failed = []
BUNDLES.each do |b|
  dirname = b
    .sub(/^.*\//, '')
    .sub(/\.git$/, '')

  if File.directory? dirname
    Dir.chdir dirname do
      system('git', 'up')
    end
  else
    system('git', 'clone', b)
    failed << b unless $?.success?
  end
end

exit(failed.length)
