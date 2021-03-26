workspace "Jianmu" "建木自动化集成平台" {
    model {
        user = person "用户" "泛指用户"
        jianmu = softwareSystem "建木自动化集成平台" "建木自动化集成平台" {
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

        user -> web "调用API"
        web -> database "Reads from and writes to" "JDBC/SSL"
        web -> daemon "下发任务执行"
        web -> daemon_process "下发任务执行"
        daemon -> web "返回执行结果"
        daemon_process -> web "返回执行结果"

        trigger -> workflow "触发流程启动"
        trigger -> task "可以直接触发任务启动"
        workflow -> task "任务节点激活事件触发任务启动"
        workflow -> task "任务节点中止事件触发任务中止"
        workflow -> parameter "读取参数信息"
        task -> parameter "读取参数信息"
    }

    views {
        container jianmu "jianmu-container" "建木容器图" {
            include *
            autoLayout
        }
        component web "web-component" "主服务组件图" {
            include *
            autoLayout
        }
        component worker1 "worker-component" "建木组件图" {
            include *
            autoLayout
        }
    }
}