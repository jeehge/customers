> 위메프1234!

> mysql -u root -p (silvy123!@#)

> SHOW FULL PROCESSLIST

[Server Info]
-----------------------------------------------------------------------------
10.105.253.11 proxy root/1234QWer
	/app/wmp/tmt/mproxy2.1
10.105.253.12 app tms root/1234QWer
	/app/wmp/tmt/ts
10.105.253.13 db      root/1234QWer
	/app/wmp/tmt/ps
10.105.253.14 tdv     administrator/1234QWer 
10.105.253.15 push    root/1234QWer
-----------------------------------------------------------------------------
[MySQL]
-----------------------------------------------------------------------------
mysql -u root -p 
silvy123!@#
-----------------------------------------------------------------------------
[my.cnf]
-----------------------------------------------------------------------------
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock

# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

collation-server = utf8_unicode_ci
character-set_server = utf8
skip-character-set-client-handshake

sql_mode = ""
skip-name-resolve
lower_case_table_names=1
max_sp_recursion_depth=255
max_connections = 3000

# slow query
slow_query_log = 1
long_query_time = 5
slow_query_log_file = /var/log/mysql-slow.log
general_log = OFF
-----------------------------------------------------------------------------
[ts/application.yml]
-----------------------------------------------------------------------------
ts:
  name: ts-1
  ip: 10.105.253.12
  tas:
    port: 15000
  web:
    port: 8081

database:
  name: mysql 
  #driverClassName: com.mysql.jdbc.Driver
  #url: jdbc:mysql://10.105.253.13:3306/wmp?zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8&useSSL=false
  driverClassName: net.sf.log4jdbc.sql.jdbcapi.DriverSpy
  url: jdbc:log4jdbc:mysql://10.105.253.13:3306/wmp?zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8&useSSL=false
  username: pbt
  password: pbt123!@#
  pool-init-size: 400
  pool-max-size: 400

hazelcast:
  port: 5701
  group:
    name: silvy
    members: 10.105.253.12:5701

logging:
        config: config/logback-spring.xml

push:
  Gcm:
    useYN: 1 
  restful:
    url: http://10.105.253.15:39080/ps/rest

user:
  profileImg:
    defaultUrl: http://wink.wemakepeople.com:31000/tmt/userProfile/
    h: 300
    ratioStayYN: 1
    reSizeYN: 1
    w: 300 

file:
  base:
    path: /app/wmp/tmt/WebAdmin/webfiles/tmt
    url: http://wink.wemakepeople.com:31000/tmt
  w2p:
    base:
      path: /app/wmp/tmt/WebAdmin/webfiles/public/resources/fileupload/TBT
      url: http://wink.wemakepeople.com:31500/public/resources/fileupload/TBT

tdv:
  ip: 10.105.253.14
  port: 12000 
  src:
    url: http://10.105.253.12:31000/tmt

-----------------------------------------------------------------------------	
[ps/config.properties]
-----------------------------------------------------------------------------
domain=m-talk.wmp
tas.name=pfs
tas.ip=10.105.253.15
tas.port=14000
tas.temp.dir=/app/wmp/tmt/ps/temp

activemq.brokerURL=failover:(tcp://10.105.253.15:61616?connectionTimeout=3000)?randomize=false&timeout=1000&maxReconnectAttempts=3&initialReconnectDelay=100

database.name=mysql
database.driverClassName=com.mysql.jdbc.Driver
database.url=jdbc:mysql://10.105.253.13:3306/wmp?zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8
database.username=pps
database.password=pps123!@#
database.initSize=50
database.minSize=50
database.maxSize=200
-----------------------------------------------------------------------------	
[mysql 관련 명령어]
-----------------------------------------------------------------------------
MySQL 5.7.24

show global variables like 'skip_name_resolve';

최대 사용자 접속수 보기

show variables like '%max_connect%';

접속수 보기

show global status like 'threads_connected';
-----------------------------------------------------------------------------	
[linux tunning 관련]
-----------------------------------------------------------------------------
ulimit -n 65000
lsof -p 127134 | wc -l


select count(*) from mpps_push_device_success where reg_dt between '2019-01-22' and '2019-01-23'
 
select right(ppc_push_key, 1) as os, count(*) from mpps_push_key_map 
group by right(ppc_push_key, 1)
