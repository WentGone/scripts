我的github
用户名：yingxingtianxia
密码：spandy910827ying
第一步
    在github网站上创建一个可用的仓库
第二步
    cd到本地需要上传的目录
    git init   #初始化本地目录为git版本库
第三步
    添加当前所有文件到git
    git add .
    做好提交准备，编写提交描述
    git commit -m "描述"
第四步
    连接到github仓库
    git remote add origin https://github.com/帐号/仓库.git
    如果报错 fatal:远程origin已经存在
    则先执行git remote rm origin
第五步
    上传项目
    git push -u origin master
    如果报错，则用
    git push -u origin +master #强制上传

如何实现push的时候免交互
git config credential.helper store
git push origin master

