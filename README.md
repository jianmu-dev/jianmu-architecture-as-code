# jianmu-architecture-as-code

#### 介绍
建木架构即代码(architecture as code)

#### 使用说明

本项目使用[Structurizr DSL](https://github.com/structurizr/dsl) 的Cli工具来生成C4 Model的架构图

该工具可以输出为PlantUML格式文件

Mac环境下可以使用Homebrew安装该工具

```
brew install structurizr-cli
```

安装完成后，可以使用以下命令来生成.puml文件到c4文件夹下

```
structurizr-cli export -workspace jianmu.dsl -format plantuml -output c4
```

#### 生成效果

*建木容器图*
![容器图](https://gitee.com/jianmu-dev/jianmu-architecture-as-code/raw/master/out/c4/structurizr-jianmu-container/%E5%BB%BA%E6%9C%A8%E8%87%AA%E5%8A%A8%E5%8C%96%E9%9B%86%E6%88%90%E5%B9%B3%E5%8F%B0%20-%20Containers.png)

*主服务内部组件图*
![组件图](https://gitee.com/jianmu-dev/jianmu-architecture-as-code/raw/master/out/c4/structurizr-web-component/%E5%BB%BA%E6%9C%A8%E8%87%AA%E5%8A%A8%E5%8C%96%E9%9B%86%E6%88%90%E5%B9%B3%E5%8F%B0%20-%20%E4%B8%BB%E6%9C%8D%E5%8A%A1%20-%20Components.png)

*执行器组件图*
![执行器组件图](https://gitee.com/jianmu-dev/jianmu-architecture-as-code/raw/master/out/c4/structurizr-worker-component/%E5%BB%BA%E6%9C%A8%E8%87%AA%E5%8A%A8%E5%8C%96%E9%9B%86%E6%88%90%E5%B9%B3%E5%8F%B0%20-%20docker-worker%20-%20Components.png)

*服务部署图*
![部署图](https://gitee.com/jianmu-dev/jianmu-architecture-as-code/raw/master/out/c4/structurizr-DevelopmentDeployment/%E5%BB%BA%E6%9C%A8%E8%87%AA%E5%8A%A8%E5%8C%96%E9%9B%86%E6%88%90%E5%B9%B3%E5%8F%B0%20-%20Deployment%20-%20dev.png)