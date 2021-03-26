workspace "Jianmu" "建木自动化集成平台" {
    model {
        user = person "用户" "泛指用户"
        jianmu = softwareSystem "建木自动化集成平台" "建木自动化集成平台" {
            singlePageApplication = container "Single-Page Application" "Provides all of the Internet banking functionality to customers via their web browser." "JavaScript and Angular" "Web Browser"
            web = container "主服务" "主服务" {
                trigger = component "触发器" "触发器上下文"
                workflow = component "流程流转" "流程上下文"
                task = component "任务分发" "任务上下文"
                parameter = component "参数管理" "参数上下文"
            }
            database = container "数据库" "Mysql 8.0"
            worker1 = container "docker-worker" "容器化执行环境" {
                daemon = component "daemon" "worker守护容器"
                runner1 = component "代码编译" "任务运行容器"
                runner2 = component "Ansible执行" "任务运行容器"
            }
            worker2 = container "shell-worker" "非容器化执行环境" {
                daemon_process = component "daemon-process" "worker守护进程"
                runner_process = component "runner-process" "任务运行进程"
            }
        }
        # 容器之间关联关系
        user -> singlePageApplication "操作或查看流程与任务"
        web -> database "Reads from and writes to" "JDBC/SSL"
        web -> daemon "下发任务执行"
        web -> daemon_process "下发任务执行"
        daemon -> web "返回执行结果"
        daemon_process -> web "返回执行结果"

        # worker内部组件关系
        daemon -> runner1 "启动容器"
        daemon -> runner2 "启动容器"

        # 主服务内部组件关系
        singlePageApplication -> trigger "启动流程或任务"
        trigger -> workflow "触发流程启动"
        trigger -> task "直接触发任务启动"
        workflow -> task "任务节点激活事件触发任务启动"
        workflow -> task "任务节点中止事件触发任务中止"
        task -> workflow "返回任务执行状态"
        workflow -> parameter "读取参数信息"
        workflow -> parameter "流程执行结果参数写入"
        task -> parameter "读取参数信息"
        task -> parameter "任务执行结果参数写入"

        deploymentEnvironment "dev" {
            deploymentNode "Web Browser" "" "Chrome, Firefox, Safari, or Edge" {
                developerSinglePageApplicationInstance = containerInstance singlePageApplication
            }
            deploymentNode "Docker Container - Web Server" "" "Docker" {
                deploymentNode "Apache Tomcat" "" "Apache Tomcat 8.x" {
                developerWebApplicationInstance = containerInstance web
                }
            }
            deploymentNode "Docker Container - Database Server" "" "Docker" {
                deploymentNode "Database Server" "" "Oracle 12c" {
                developerDatabaseInstance = containerInstance database
                }
            }
            deploymentNode "Docker Container - Worker Server" "" "Docker" {
                deploymentNode "Worker Server" "" "Golang" {
                developerWorkerInstance = containerInstance worker1
                }
            }
        }
    }

    views {
        container jianmu "jianmu-container" "建木容器图" {
            include *
            autoLayout
        }
        component web "web-component" "主服务组件图" {
            include *
            autoLayout lr 400
        }
        component worker1 "worker-component" "执行器组件图" {
            include *
            autoLayout lr
        }
        deployment jianmu "dev" "DevelopmentDeployment" {
            include *
            autoLayout
        }
    }
}