#vfox activate fish | source
set -x  JAVA_HOME /home/xi/.version-fox/cache/java/current
set -x  GRADLE_HOME /home/xi/.version-fox/cache/gradle/current
set -x  MAVEN_HOME /home/xi/.version-fox/cache/maven/current
# set -x  PYTHON_HOME /home/xi/.version-fox/cache/python/current
set -x GRADLE_USER_HOME /home/xi/.m2/repository
set -x JDTLS_HOME /home/xi/.local/share/nvim/mason/packages/jdtls/bin
set -x PATH $JAVA_HOME/bin $GRADLE_HOME/bin $MAVEN_HOME/bin $PYTHON_HOME/bin $GRADLE_USER_HOME $JDTLS_HOME $PATH

fish_vi_key_bindings


bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line


# abbr 会自动展开，可以看到实际命令
abbr -a blog cd /home/xi/Documents/Docker/hexo/blogs
abbr -a vihome cd /home/xi/.config/nvim
abbr -a sfh source /home/xi/.config/fish/config.fish
abbr -a code /home/xi/Documents/Code-Space
abbr -a codeg /home/xi/Documents/Code-Space/gxi/project
abbr -a dotcfg /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
vfox activate fish | source
