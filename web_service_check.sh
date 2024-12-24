#/bin/bash 

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m'      # ${NORMAL} 
 
# Цветом текста (жирным) (bold) :
WHITE='\033[1;37m'    # ${WHITE}
 
# Цвет фона
BGRED='\033[41m'      # ${BGRED}
BGGREEN='\033[42m'    # ${BGGREEN}
BGBLUE='\033[44m'     # ${BGBLUE}
 
echo -en "${WHITE} ${BGRED} Привет $(whoami)";
sleep 1
# Получаем статус веб-сервера через systemd  записываем его в переменную.
nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed") 
 
            if [[ $nginxstatus = 'running' ]]
                then
                    echo -en  "${WHITE} ${BGGREEN} Веб сервер работает ${NORMAL}\n"
                else 
                    echo -en "${WHITE} ${BGRED} nginx не работает ${NORMAL}\n"
                    systemctl restart nginx # Перезапуск nginx
                    sleep 1 #  Ожидаем 1 секунду, чтобы сервер точно запустился. 
                    
                    echo -en "${WHITE} ${BGGREEN} Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") ${NORMAL}\n"
                    echo $(curl -I 192.168.88.230 | grep OK) # Проверяем отдает ли веб-сервер http код 200
            fi 
#sleep 1
            
# Получаем статус php через systemd  записываем его в переменную.
phpfpmstatus=$(systemctl status  php-fpm.service | grep -Eo "running|dead|failed")
 
            if [[ $phpfpmstatus = 'running' ]]
                then
                    echo -en  "${WHITE} ${BGGREEN} php7.2-fpm работает ${NORMAL}\n"
                else 
                    echo -en "${WHITE} ${BGRED} Статус php7.2-fpm $phpfpmstatus Пробуем перезапустить. ${NORMAL}\n"
                    systemctl restart  php-fpm.service # Перезапуск php7.2-fpm
                    sleep 1 #  Ожидаем 1 секунду, чтобы php7.2-fpm точно запустился. 
                    
                    echo -en "${WHITE} Статус php7.2-fpm после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") ${NORMAL}\n"
            fi 
#sleep 1

# Получаем статус grafana через systemd  записываем его в переменную.
grafanastatus=$(systemctl status  grafana-server.service | grep -Eo "running|dead|failed")

            if [[ $grafanastatus = 'running' ]]
                then
                    echo -en  "${WHITE} ${BGGREEN} grafana работает ${NORMAL}\n"
                else
                    echo -en "${WHITE} ${BGRED} Статус grafana $grafanastatus Пробуем перезапустить. ${NORMAL}\n"
                    systemctl restart  grafana-server.service
                    sleep 1 
                    echo -en "${WHITE} Статус grafana после перезапуска $(systemctl status grafana-server | grep -Eo "running|dead|failed") ${NORMAL}\n"
            fi
#sleep 1
			
# Получаем статус prometheus через systemd  записываем его в переменную.
prometheusstatus=$(systemctl status  prometheus.service | grep -Eo "running|dead|failed")

            if [[ $prometheusstatus = 'running' ]]
                then
                    echo -en  "${WHITE} ${BGGREEN} prometheus работает ${NORMAL}\n"
                else
                    echo -en "${WHITE} ${BGRED} Статус prometheus $prometheusstatus Пробуем перезапустить. ${NORMAL}\n"
                    systemctl restart  prometheus.service
                    sleep 1 

                    echo -en "${WHITE} Статус prometheus после перезапуска $(systemctl status prometheus.service | grep -Eo "running|dead|failed") ${NORMAL}\n"
            fi


