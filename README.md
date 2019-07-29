## PHP docker 开发环境

1. 环境目录结构说明

   ```shell
   Env
   ├── config						 # 本地配置文件目录（git 忽略目录）
   ├── data						  # 服务类容器数据存储目录 (git 忽略目录)
   ├── env_builds			  # 镜像构建目录
   ├── init.sh                      # 初始化启动脚本
   ├── reference               # 基准配置 (仅供参考，请勿修改)
   └── wwwroot               # 项目放置位置 挂载到各容器/wwwroot (git忽略目录)
   ```

2. 启动前置环境

   > 确保本机已经 安装 git docker 以及 docker-compose
   >
   > docker 安装请参考 [docker 官方文档](<https://docs.docker.com/install/> "安装指南")
   >
   > git  安装请前往 [Git 官网](<https://git-scm.com/>  "Git") 下载

3. 启动容器

   ```shell
   git clone git@git.qshsc.com:zjyth/docker-env.git Env
   # 或者，推荐使用 git 协议进行拉取
   git clone http://git.qshsc.com/zjyth/docker-env.git Evn

   # 执行初始化脚本，复制启动配置文件
   ./init.sh
   ```

4. 默认密码，服务名

   > 以下所有容器默认密码均为 12306

   - 容器内连接 Mysql, 连接 `host` 即为 `mysql`，`port` **3306**
   - 容器内连接 Redis, 连接 `host` 即为 `redis`, `port` **6379**
   - 容器内连接 rabbitmq, 连接 `host`即为 `rabbitmq`, `port` **5672**, `rabbitmq management` port **15672**

