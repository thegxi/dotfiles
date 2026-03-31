#vfox activate fish | source
set -x  JAVA_HOME /home/xi/.version-fox/cache/java/current
set -x  GRADLE_HOME /home/xi/.version-fox/cache/gradle/current
set -x  MAVEN_HOME /home/xi/.version-fox/cache/maven/current
# set -x  PYTHON_HOME /home/xi/.version-fox/cache/python/current
set -x GRADLE_USER_HOME /home/xi/.m2/repository
set -x JDTLS_HOME /home/xi/.local/share/nvim/mason/packages/jdtls/bin
set -x PATH $JAVA_HOME/bin $GRADLE_HOME/bin $MAVEN_HOME/bin $PYTHON_HOME/bin $GRADLE_USER_HOME $JDTLS_HOME $PATH

# 必须先声明进入 Vi 模式
fish_vi_key_bindings

# 定义按键绑定函数（这是 Fish 处理自定义绑定的标准做法）
function fish_user_key_bindings
    # 在插入模式下：
    bind -M insert \cf accept-autosuggestion      # Ctrl + F 采纳建议
    bind -M insert \ca beginning-of-line         # Ctrl + A 到行首
    bind -M insert \ce end-of-line              # Ctrl + E 到行尾
    # 在 Normal 模式下（可选）：
    bind -M default \cf accept-autosuggestion
end

# abbr 会自动展开，可以看到实际命令
abbr -a blog cd /home/xi/Documents/Docker/hexo/blogs
abbr -a vihome cd /home/xi/.config/nvim
abbr -a sfh source /home/xi/.config/fish/config.fish
abbr -a code /home/xi/Documents/Code-Space
abbr -a codeg /home/xi/Documents/Code-Space/gxi/project
abbr -a dotcfg /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME
abbr -a sd systemctl start docker

vfox activate fish | source
