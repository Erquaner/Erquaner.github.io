#!/bin/bash
# 部署到 github pages 脚本
# 错误时终止脚本
set -e

# 删除打包文件夹
rm -rf public

# 打包
hugo

# 进入打包文件夹
cd public

# add
git init

# 添加远程仓库
git remote add origin  git@github.com:Erquaner/Erquaner.github.io.git

git add -A

# 提交
# msg="building site `date`"
# if [ $# -eq 1 ]
#   then msg="$1"
# fi

read -p "Enter your commit msg: " commitMsg

read -p "Are you sure to commit? [y/n]": sure

case $sure in 
    [yY]*) 
        git commit -m "$commitMsg"
        echo "commit with $commitMsg successfully."
        ;;
    [nN]*)
        exit
        ;;
    *)
      echo "just enter y or n, please."
      exit
      ;;
esac

# 推送到github
git push -f origin master

# 回到原文件夹
cd ..

echo ".DS_Store
*.swap" > .gitignore