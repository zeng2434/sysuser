
#! /bin/bash

read -p "请输入要查询的用户名：" name

echo "------------------------------"

n=`cat /etc/passwd | awk -F: '$1~/^'${name}'$/{print}' | wc -l`

if [ $n -eq 0 ];then
echo -e "\e[31m该用户不存在！\e[0m"
echo "------------------------------"
else
  echo "该用户的用户名：${name}"
  echo "该用户的UID：$(cat /etc/passwd | awk -F: '$1~/^'${name}'$/{print}'|awk -F: '{print $3}')"
  echo "该用户的组为：$(id ${name} | awk {'print $3'})"
  echo "该用户的GID为：$(cat /etc/passwd | awk -F: '$1~/^'${name}'$/{print}'|awk -F: '{print $4}')"
  echo "该用户的家目录为：$(cat /etc/passwd | awk -F: '$1~/^'${name}'$/{print}'|awk -F: '{print $6}')"
  Login=$(cat /etc/passwd | awk -F: '$1~/^'${name}'$/{print}'|awk -F: '{print $7}')
  if [ ${Login} == "/bin/bash" ];then
  echo -e "\e[32m该用户有登录系统的权限\e[0m"
  echo "------------------------------"
  elif [ ${Login} == "/sbin/nologin" ];then
  echo -e "\e[31m该用户没有登录系统的权限！\e[0m"
  echo "------------------------------"
  fi
fi
