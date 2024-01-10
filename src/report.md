## Part 1. Готовый докер
`` - 1.1 Взять официальный докер образ с nginx и выкачать его при помощи docker pull`` 

``docker pull nginx``

![Alt text](screens/task1.1.png "Optional Title") <br>

`` - 1.2 Проверить наличие докер образа через docker images``

``команда - docker images``

![Alt text](screens/task1.2.png "Optional Title") <br>

``- 1.3 Запустить докер образ через docker run -d [image_id|repository]``

``команда - docker run -d 89da1fb6dcb9``

![Alt text](screens/task1.3.png "Optional Title") <br>

`` - 1.4 Проверить, что образ запустился через docker ps``

``sudo docker ps``

![Alt text](screens/task1.4.png "Optional Title") <br>

`` - 1.5 Посмотреть информацию о контейнере``

![Alt text](screens/task1.5.png "Optional Title") <br>




``- 1.6 По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера``

`` sdo docker inspect ac50300768ed --size | grep -i SizeRw``

![Alt text](screens/task1.6.png "Optional Title") <br>


``найдём в выводе команды sudo docker inspect  список портов``


![Alt text](screens/task1.7.1.png "Optional Title") <br>

`` найдём ip контейнера командой sudo docker inspect ac50300768ed --size | grep -i ip``

![Alt text](screens/task1.7.png "Optional Title") <br>


`` - 1.7 Остановить докер образ через docker stop ac50300768ed ``

![Alt text](screens/task1.8.png "Optional Title") <br>



`` - 1.8 Проверить, что образ остановился через docker ps``


![Alt text](screens/task1.9.png "Optional Title") <br>


`` - 1.9 Запустить докер с замапленными портами 80 и 443 на локальную машину через команду run``

``sudo docker run -d -p 80:80 -p 443:443 nginx``

![Alt text](screens/task1.10.png "Optional Title") <br>

`` проверяем запуск и порты sudo docker ps``

![Alt text](screens/task1.11.png "Optional Title") <br>

`` - 1.10 Проверить, что в браузере по адресу localhost:80 доступна стартовая страница nginx``

![Alt text](screens/task1.12.png "Optional Title") <br>


## Part 2. Операции с контейнером

``- 2.1 Прочитать конфигурационный файл nginx.conf внутри докер контейнера через команду exec``

``используем команду sudo docker exec 5c02c59c7852 cat /etc/nginx/nginx.conf``


![Alt text](screens/task2.1.png "Optional Title") <br>


`` - 2.2 Создать на локальной машине файл nginx.conf``

![Alt text](screens/task2.2.png "Optional Title") <br>

`` - 2.3 Настроить в нем по пути /status отдачу страницы статуса сервера nginx``


![Alt text](screens/task2.3.png "Optional Title") <br>

`` - 2.4, 2.5 Скопировать созданный файл nginx.conf внутрь докер образа через команду docker cp``

``копируем файл командой sudo docker cp nginx.conf 6c86bc252e0e:etc/nginx/``
``Перезапустить nginx внутри докер образа через команду exec``
``docker exec 6c86bc252e0e nginx -s reload``


![Alt text](screens/task2.4.5.png "Optional Title") <br>


`` -2.6 Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx``

![Alt text](screens/task2.6.png "Optional Title") <br>

``- 2.7 Экспортировать контейнер в файл container.tar через команду export``

``sudo docker export -o container.tar 6c86bc252e0e``

![Alt text](screens/task2.7.png "Optional Title") <br>


``- 2.8 Остановить контейнер``

``sudo docker stop 6c86bc252e0e``

![Alt text](screens/task2.8.png "Optional Title") <br>

`` - 2.9 Удалить образ через docker , не удаляя перед этим контейнеры``

``удаляем образ командой sudo docker rmi -f nginx``

![Alt text](screens/task2.9.png "Optional Title") <br>

`` - 2.10 Удалить остановленный контейнер``
``удаляем контейнер командой sudo docker rm 6c86bc252e0e``

![Alt text](screens/task2.10.png "Optional Title") <br>


`` - 2.11 Импортировать контейнер обратно через команду import``

``sudo docker import -c 'CMD ["nginx", "-g", "daemon off;"]' container.tar part_2``

![Alt text](screens/task2.11.png "Optional Title") <br>

`` - 2.12 Запустить импортированный контейнер``

``запускаем контейнер командой sudo docker run -d -p 80:80 -p 443:443 part_2``

![Alt text](screens/task2.12.png "Optional Title") <br>

`` - 2.13 Проверить, что по адресу localhost:80/status отдается страничка со статусом сервера nginx``

![Alt text](screens/task2.13.png "Optional Title") <br>


## 3. Мини веб-сервер

`` - 3.1 Пишу мини сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello World!``

![Alt text](screens/task3.1.png "Optional Title") <br>

`` - 3.2 3.2 Написать свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080``

![Alt text](screens/task3.2.png "Optional Title") <br>

`` - 3.3 Запустить написанный мини сервер через spawn-fcgi на порту 8080``



``docker pull nginx``
``docker images``
``docker run -d -p 81:81 89da1fb6dcb9``
``docker ps``

![Alt text](screens/task3.3.png "Optional Title") <br>

`` - 3.4 Заходим в контейнер командой docker exec -it 521cee2f0888 bash, обновляем репозитории, устанавливаем gcc, spawn-fcgi и libfcgi-dev``

``docker cp nginx.conf 521cee2f0888:/etc/nginx/``
``docker cp server.c 521cee2f0888:/home/``
``docker exec -it 521cee2f0888 bash     // чтобы подключиься к контейнеру``

![Alt text](screens/task3.4.png "Optional Title") <br>

``gcc *.c -lfcgi``
``spawn-fcgi -p 8080 /screenshots/a.out``
``nginx -s reload``

![Alt text](screens/task3.5.png "Optional Title") <br>

``- 3.4 Проверить, что в браузере по localhost:81 отдается написанная вами страничка``


![Alt text](screens/task3.4.1.png "Optional Title") <br>


![Alt text](screens/task3.4.2.png "Optional Title") <br>

## 4. Свой докер

``Dockerfile``

![Alt text](screens/task4.1.png "Optional Title") <br>

``скрипт, выполняющий роль run.sh``


![Alt text](screens/task4.2.png "Optional Title") <br>

``Собираем образ через docker build при этом указав имя и тег``

![Alt text](screens/task43.png "Optional Title") <br>

``проверяем через docker images, что все собралось корректно``

![Alt text](screens/task4.4.png "Optional Title") <br>


``Дописать в /screenshots/nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx``


![Alt text](screens/task4.5.png "Optional Title") <br>

``Перезапустить докер образ``

![Alt text](screens/task4.6.png "Optional Title") <br>

![Alt text](screens/task4.7.png "Optional Title") <br>



## 5. Dockle

`` Для начала устанавливаем dockle``

![Alt text](screens/task5.png "Optional Title") <br>

``потом проверим образ``

![Alt text](screens/task5.2.png "Optional Title") <br>

``устроняем ошибку``


![Alt text](screens/task5.3.png "Optional Title") <br>

``еще раз проверяем``

![Alt text](screens/task5.4.png "Optional Title") <br>


## 6. Базовый Docker Compose

``Написать файл docker-compose.yml, с помощью которого:``

``Поднять докер контейнер из Части 5 (он должен работать в локальной сети, т.е. не нужно использовать инструкцию EXPOSE и мапить порты на локальную машину)``


``Поднять докер контейнер с nginx, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера``

![Alt text](screens/task6.png "Optional Title") <br>

``Замапить 8080 порт второго контейнера на 80 порт локальной машины``

![Alt text](screens/task6.2.png "Optional Title") <br>

``Собрать и запустить проект с помощью команд docker-compose build и docker-compose up``
![Alt text](screens/task6.3.png "Optional Title") <br>

![Alt text](screens/task6.4.png "Optional Title") <br>

``Проверить, что в браузере по localhost:80 отдается написанная вами страничка, как и ранее``

![Alt text](screens/task6.5.png "Optional Title") <br>

t