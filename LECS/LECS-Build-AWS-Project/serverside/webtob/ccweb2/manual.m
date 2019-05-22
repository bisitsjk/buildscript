# 
# WebtoB Configuration Reference
# 
# 해당 절과 해당 항목에 관한 보다 자세한 정보를 원한다면 "WebtoB Administrator's Guide"를 참고하기 바란다.
# 
# 본 설정은 WebtoB 4.1을 기준으로 한다.
# 

#####
##### DOMAIN 절 
#####
# 독립적인 WebtoB 시스템의 전반적인 환경 설정을 할 수 있다.
*DOMAIN

# 도메인 네임은 string 형식으로 31자까지 사용 가능. 
# 다른 절들의 string 항목도 이와 동일하다.
webtob1


#####
##### NODE 절
#####
# WebtoB를 이루는 각 Node들에 대한 구체적인 환경 설정을 할 수 있다.
# 필수 항목으로 WebtobDir, ShmKey, DocRoot 항목을 설정해야 있다.
*NODE

# 실제 등록된 호스트의 이름을 말하며, UNIX의 경우 "uname -n" 명령으로 각 Host의 이름을 확인할 수 있다. 
# Node명은 반드시 UNIX의 경우 "/etc/hosts"(Windows의 경우 C:\WINNT\system32\drivers\etc) 파일에 등록되어 있어야 한다.
# 하나의 Domain은 하나 이상의 Node로 이루어지므로, NODE절에는 최소한 하나 이상의 Node 이름이 정의되어야 한다.
WebServer  

# WebtoB가 설치되어 있는 Home Directory 의 절대 경로명이다.
# 환경변수로 정의되는 WEBTOBDIR 과 동일한 값으로 설정하면 된다.
                WebtobDir = "/data2/wbqam/webtob",

# Shared Memory Segment를 가리키는 값이다.
# 32768 ~ 262143 범위 내에서 다른 업무에 사용되는 키값과 충돌이 나지 않게 Shared Memory의 Key값을 설정 하면 된다.
                ShmKey = 78100,

# WebtoB가 웹을 통해 서비스하는 모든 문서를 포함하는 Root Directory 의 절대 경로를 설정한다.
                DocRoot="/data2/wbqam/webtob/docs",

# HTTP Request Handler) Process의 개수를 설정한다.
# Hth하나당 약 800개 이상의 Client를 수용할 수 있다.
# Default Number 설정은 1 이며, 최대 20개 까지 지정할 수 있다.
                Hth = 2,

# WebtoB가 Listen하는 Port를 지정한다.
# 일반적으로 Web Server는 80 Port 이용하므로 설정하지 않을경우 default 값으로 80으로 설정된다.
# 최대 100개의 포트를 동시에 지정하여 사용할 수도 있다.
# Listen 항목과 동시에 운영할 수 없으며, Port보다 Listen항목에서 지정되는 Port가 우선순위가 높아
# 동시에 지정하면 Port항목은 무시 된다.
                Port = "8100,8200",

##### User, Group 설정
# WebtoB에서 시스템의 보안을 위하여 WebtoB의 실제 실행 Process에 대한 권한 설정을 할 수 있다.
# 설정한 권한으로 Process가 실행되기 위해서는 반드시 root 권한으로 WebtoB를 실행해야 한다.

# 설정된 Group의 권한으로 WebtoB가 요구를 수행하게 된다.
# Client 요구를 수행하기 위하여 Group 설정을 권장한다.
# Group 설정은 Unix계열의 OS에서만 지원한다.
               Group = "nobody",

# 설정된 User의 권한으로 WebtoB가 요구를 수행하게 된다.
# Client 요구를 수행하기 위하여 User 설정을 권장한다.
# User 설정은 Unix계열의 OS에서만 지원한다.
               User = "nobody",

# 관리자의 정보를 나타낸다.
# 관리자에게 연락할 수 있는 e-mail address를 설정할 수 있다.
                Admin = "wbqam@tmax.co.kr",

# Http Response Header의 host name field에 기록될 값을 설정할 수 있다.
                HostName = "www.tmax.co.kr",

# 해당 서버의 HostName를 적어 준다.
# 특별히 $(NODENAME)이라고 적어주면, 자동으로 해당 서버의 HostName가 적용된다.
# 한글 노드명을 사용하거나 긴 노드명을 사용할 경우 NodeName 을 설정한다.
		NodeName = "$(NODENAME)"

# MultiNode 설정시 각 Node들 간의 연결 Port 번호를 지정한다. 
# MultiNode 설정시 반드시 지정해 주어야 한다.
# default 설정은 7777 번이다.
#                NodePort = 7777,

# WebtoB와 Servlet 수행 Server간의 연결 Port 번호를 지정한다.
# default 설정은 9999 번이다.
                JSVPort = 9100,

# Multi Node 구성시 Node 관리 차원에서 Node간 통신을 위한 Port번호를 지정한다. 
# 위의 NodePort와는 달리 이것은 관리 Process 중 하나인 wsracd Daemon에서 사용하는 Port번호이다.
# default 설정은 3333 번이다.
                RacPort = 4455,

# WebtoB는 Server 내부 Caching의 한 Entry의 크기로서 기본단위는 Kbyte이다.
# default size는 128 Kbyte 이다.
                CacheSize = 128,

# Cache의 총 Hashing Key 엔트리 개수를 설정한다.
# default 개수는 128개 이다.
                CacheEntry = 256,

# HTML file에 대한 cache refresh time을 설정한다.
# default 설정은 0 second 이다.
                CacheRefreshHtml = 60,

# DirIndex에 대한 cache refresh time을 설정한다.
# default 설정은 0 second 이다.
                CacheRefreshDir = 60,

# 사용자가 웹사이트에 접속한 후, 다른 웹페이지를 읽어 들이기 위해 곧 다시 접속을 시도 할 경우 
# 불필요한 시간 지연이 없도록 하려면 이 항목을 지정함으로써 접속을 단절하지 않고 유지할 수 있다.
                KeepAlive = Y,

# 커넥션 설정후 일정 개수의 요구는 커넥션을 유지한 상태로 서비스를 하고 커넥션을 끊도록 하는데,  
# 커넥션을 끊기 전에 들어주는 요구의 개수를 지정한다.
# default 설정은 9999 이다.
                KeepAliveMax = 10,

# 하나의 Client가 불필요하게 커넥션을 오래 잡고 있는 경우를 막기 위해
# 다음 Request 까지 일정 시간 이상이 되면 커넥션을 끊을 수 있도록 설정할 수 있다.
# default 설정은 60 second 이다.
                KeepAliveTimeout = 30,

# 사용자의 최대 접속시간을 지정한다.
# default 설정은 300 second 이다.
                Timeout = 100,

# WebtoB를 통해 사용자별로 동시에 서비스 하려는 경우 설정한다.
# 값이 설정이 되면 각 사용자의 directory를 찾아서 서비스 한다.
                UserDir = "public_html",

# WebtoB를 통해 응용 프로그램을 바로 호출하는 경우 해당 프로그램이 위치할 디렉토리를 설정한다. 
# 경로명은 절대 경로와 WEBTOBDIR을 기준으로 한 상대 경로를 사용할 수 있다.
                AppDir = "/data2/wbqam/webtob/ap",

##### Log Directory
# WebtoB에서는 기본적으로 Log 정보를 남기기 위하여 설정한다.
# 환경파일에 따로 설정하지 않을경우 WEBTOBDIR/log 디렉토리에 기록이 된다.
# 로그가 기록될 디렉토리가 없을경우 booting시 에러가 나므로, 실제 존재하는 디렉토리여야 한다.
# 경로명은 절대 경로와 WEBTOBDIR을 기준으로 한 상대 경로를 사용할 수 있다.

# 시스템 메시지가 기록될 Directory의 경로명을 설정한다.
# Default Path는 (WEBTOBDIR)/log/syslog 이다.
#                SysLogDir = "/data2/wbqam/webtob/log/syslog",
# SysLogDir 은 더 이상 유효하지 않다.

# 사용자 메시지가 기록될 Directory의 경로명을 설정한다. 
                UsrLogDir = "/data2/wbqam/webtob/log/usrlog",

# Service Directory로 요청이 올대 기본적으로 서비스되는 파일 이름을 설정한다.
# 기본 설정은 index.html 이다.
                IndexName = "indexname.html",

# NODE 에 적용되는 옵션을 지정한다.
# HTML: HTML 서버 사용결정
# CGI: CGI 서버 사용결정
# SSI: SSI 서버 사용결정
# PHP: PHP 서버 사용결정
# JSV: JSV (JEUS) 서버 사용결정
# INDEX: Indexing 기능 사용결정
# INCLUDE: Include (SSI) 서버 사용결정
# 위 모든 기능을 이용하려면 "+ALL", 모든 기능을 이용하지 않으려면 "-ALL"을 설정할 수 있다.
#
# StrictAuthorizationHdrFormat: HTTP Authorization header field 의 format 검사를 결정한다.
# + 설정인경우 HTTP request 의 Authorization header field 의 format 을 검사하고, format 에
# 맞지않은 request 는 거절한다.
# - 설정인경우 HTTP 에 정의되지않은 값은 무시하고 요청을 처리한다.
#
# Default = +ALL,+StrictAuthorizationHdrFormat
                Options = "+Index,-StrictAuthorizationHdrFormat",

# Client가 보내는 Request Method에 대한 정의를 할 수 있다.
# HEAD, GET, POST, OPTIONS 등을 설정을 할 수 있으며, 사용하고 싶지 않을경우 "-Option" 으로 설정하면 된다.
# 참고로 HTTP Method CONNECT, DELETE, GET, HEAD, OPTIONS, POST, PUT, TRACE 등이 있다.
                Method = "GET,POST,HEAD,-OPTIONS",

# 여러개의 IP Address를 가진 Server에서 자신이 원하는 IP로만 서비스 하기를 원할때 지정한다.
# 여러개의 아이피와 포트를 지정할 수도 있다.
# Port항목과 Listen 항목을 동시에 지정하는 경우 Port에 지정한 Port는 무시된다.
#               Listen="192.168.1.43:8300",

# DIRINDEX절에서 설정하는 디렉토리 인덱스의 이름을 적어준다.
                DirIndex = "diridx_def"

# 접속 Client가 사용 언어를 지정하지 않았을 경우
# Server쪽에서 지정된 언어 순서대로 Multiview request 등의 처리가 이루어지도록 한다.
                LanguagePrio = "kr",

# LOGGING절에서 설정하는 Logging Name을 설정하며, 해당 설정에 해당하는 Log를 남기게 되는 것이다.
                Logging = "log1",

# LOGGING절에서 설정하는 Logging Name을 설정하며, 해당 설정에 따라 Error Log를 남기게 된다.
                ErrorLog = "log2",

# LOGGING절에서 설정하는 Logging Name을 설정하며, 해당 설정에 따라 Sys Log를 남기게 된다.
		SysLog = "syslog",

# WebtoB에서 특정 정보를 읽어 들일 필요가 있는 경우 이용된다.
#                EnvFile = "WebtoB.env",

# WebtoB에서 SSL을 이용할 때 Y 로 설정한다. 
# default 설정은 N 이다.
#                SslFlag = Y,

# SslFlag = Y 상태일때 적용이 되며, SSL절에 설정한 Ssl Name를 지정한다.
#                SSLNAME = "ssl_def",

# 서버 프로세스에 속한 노드의 최대 동시 접속자 수를 설정한다.
                MaxUser = 4000,

# WebtoB 내부 프로세스의 접근권한을 설정한다.
# Default 설정은 0700 이다.
#                IpcPerm = 0744,

# WebtoB log file 들의 permission 값을 설정한다.
# Default 설정은 0600 이다.
#                LogPerm = 0644,

# 접속을 기다리는 큐(queue)의 길이를 제한하는 것으로, 
# 서버가 대량의 접속 시도를 한꺼번에 날려주는 TCP SYN해킹을 당하고 있다면 유용하게 사용 될수 있을 것이다.
# default 설정은 511 이다.
                ListenBacklog = 100,

# TCP 전송 Buffer의 크기를 설정하는 것으로, 이 항목을 이용하면 특정한 환경에서 동작 속도를 향상시킬 수 있다. 
# default 설정은 0이며, 0의 값은 OS default값을 사용함을 의미한다.
                SendBufferSize = 4096,

# 클라이언트의 요청시 HTTP 프로토콜을 통해 서버가 제공할 수 있는 Request Body 크기를 바이트 단위로 정의하는 것으로, 
# 0의 값은 크기에 제한이 없음을 의미한다.
# default 설정은 0 bytes 이다.
                LimitRequestBody = 20000,

# 클라이언트의 요청시 허용되는 HTTP Request header field의 수를 설정한다. 
# 0의 값은 제한이 없음을 의미한다.
# default 설정은 100 이다.
                LimitRequestFields = 20,

# 클라이언트의 요청시 허용되는 각 HTTP Request header field의 크기를 설정한다. 
# 최대 허용되는 값은 8190이다.
# default 설정은 8190 bytes 이다.
                LimitRequestFieldSize = 300,

# 클라이언트의 요청시 허용되는 HTTP Request line의 최대 크기를 설정한다. 
# 최대 허용되는 값은 8190이다.
# default 설정은 8190 이다.
                LimitRequestLine = 4000,

# HTTP 응답 헤더의 Server에 관한 정보를 어떻게 다룰지 결정한다.
# "Off", "Prod[uctOnly]", "Min[imal]", "OS", "Full", "Custom=xxx/x.x" 등을 설정할 수 있다.
# Default 값은 "Off".
                ServerTokens = "Off",

# HTTP 요청으로부터 해당 Server와 Service를 결정할때, URI절과 EXT절의 우선순위를 결정한다. 
# Vhost절에 이 항목이 설정되지 않은 경우는 Node절에 설정된 값이나 기본값을 Vhost가 따르게 된다.
# default 설정은 "uri,ext" 이다.
                ServiceOrder = "ext,uri",

# HTTP header의 Content-Type에 character set 설정이 없는 Request에 응답에 추가될 character set의 이름을 설정한다.
# "On"(ISO-8859-1), "Off"(설정안함), "_charset_"(사용자 기술) 중 하나를 설정할 수 있다.
# 여러 절에서 적용되는 우선 순위는 Node < Vhost < SvrGroup < Directory 순이다.
                DefaultCharset = "Off",

# MIME-Type을 결정할 수 없는 문서의 Default Content-Type을 설정한다. 
# Default Content-Type은 SvrGroup, Vhost, Node절의 순으로 결정된다
                DefaultMimetype = "text/html",

# Web Server에서 내부 프로세스간 IPC통신을 하기 위해서 기본적으로 특정 포트(6666)를 사용하는데, 
# IPCBasePort항목을 통해 해당 포트를 변경할 수 있다. 
# 현재 Windows에서만 지원된다. (UNIX의 경우 PIPE통신)
# default 설정은 6666 이다.
#                IpcBasePort = 6667,

# EXPIRES절의 설정한 Expires이름을 설정한다.
                Expires = "exp11, exp12, expdef1",

# TCPGW 절에 설정한 tcpgw 이름을 설정한다.
                TcpGW = "tcpgw_full",

# ERRORDOCUMENT절에 설정한 ErrorDocument 이름을 설정한다.
                ErrorDocument = "404",

# WebtoB 내부 프로세스 통신을 위한 socket생성 디렉토리를 설정한다.
# default 설정은 $WEBTOBDIR/path 이다.
                PathDir="/data2/wbqam/webtob/path",


##### 멀티노드 구성시 아래와 같이 추가적으로 노드를 정의한다.
#tmaxi1  
#                WEBTOBDIR="/data/wbqam/webtob",
#                SHMKEY = 78100,
#                DOCROOT="/data/wbqam/webtob/docs",
#                APPDIR="/data/wbqam/webtob/ap",
#                PORT = "8100",
#                HTH = 2,
#                LOGGING = "log5",
#                ERRORLOG = "log6",
#                HostName = "www.tmax.co.kr",
#                RACPORT = 4455,
#                NodePort = 7787

# CGI, PHP 요청처리중 client 가 connection 을 끊을경우,
# 작동중인 CGI, PHP process 를 중단/완료시까지 처리를 결정한다.
# Y 설정: process 강제 종료
# N 설정: 요청처리후 process 정상 종료
# Default = Y 
                 TerminateCgiUponClientClose = Y,

# HTTP Etag 사용을 결정한다.
# Y 설정: HTTP response 에 가능하면 Etag 추가하고, HTTP request 의 Etag 도 사용한다.
# N 설정: HTTP response 에 Etag 를 추가하지않음.  HTTP request 의 Etag 는 무시한다.
# Default = Y
                 UseEtag = Y,

# Apache mod_rewrite port 기능 사용을 결정한다.
# Y 설정: 사용한다.  URLRewriteConfig 설정이 필요하다.
# N 설정: 사용하지않은다.
# Default = N
                 URLRewrite = N,

# Apache mod_rewrite port 용 설정파일 경로지정.
# 설정파일은 Apache 2.2 mod_rewrite 의 설정 방법과 동일하다.
# 다음 기능은 제공되지 않은다.
# %{SSL:variable}
# %{LA-U:variable}
# %{LA-F:variable}
# %{IS_SUBREQ}
# %{PATH_INFO}
# %{API_VERSION}
# %{REMOTE_HOST}
# %{SCRIPT_USER}
# %{SCRIPT_GROUP}
# %{REMOTE_IDENT}
# %{SERVER_ADMIN}
# %{SCRIPT_FILENAME}
# %{REQUEST_FILENAME}
# RewriteMap
# 'B' (escape backreferences)
# 'proxy|P' (force proxy)
                 URLRewriteConfig = "/webtob/config/rewrite.cfg",

# Reverse proxy 에서 client connection 이 끊어진 후 서버의 keep-alive connection 
# 을 끊지않고 유지할수있다.  이와같은 connection 의 최대 개수를 지정한다.
# Default = 0
# 경고: 인발적인 경우 설정하지않아야 한다.
                 MaxReverseProxyKeepAliveServerConnections = 16,

# Reverse proxy 가 요청을 수정하여 내부 서버로 전달할 당시 사용되는
# 메모리 버퍼의 최초크기.  최초 요청의 HTTP header field 개수가 많을경우,
# 이 값을 증가하면 성능향상이 있을 수 있다.  단위는 byte.
# Default = 1024
                 ReverseProxyRequestSlackBufferSize = 2048,

# Error 응답 (3XX 이상의 status code) 를 보낸후 WebtoB 는 client 연결을 끊는다.
# KeepAliveErrorStatusCode 에 특정 status code 를 설정하면, 설정된 status code 를
# 가진 응답을 보낸후 client 연결을 유지한다.
# Default 값은 "" (empty string).
                 KeepAliveErrorStatusCode = "301,302",

# HtmlsForbidsWEBINF = Y 로 설정되면, HTMLS 가 static file 요청을 처리하기 전,
# 파일 경로가 /WEB-INF/ (case insensitve) 포함되는지 판단한다.  포함하면
# 403 Forbidden 응답을 보낸다.  JEUS application 파일들에대한 접근을 막을 수 있다.
# Default 값은 Y.
                 HtmlsForbidsWEBINF = Y,

# Access log 메시지들은 WSM 을 통해서 파일로 기록된다.  AccessLogThroughWSM = N 로 설정하면,
# UNIX 장비에서는 WSM 을 통하지 않고 각 WebtoB process 들이 직접 파일로 기록할 수 있다.
# Windows 버전은 N 를 설정할 수 없다.
# Default 값은 Y.
                 AccessLogThroughWSM = Y,

# HTH 가 chunked request 를 non-chunked request 로 변환한다.  이때 허용되는 최대 요청크기를
# 설정한다.  단위는 바이트.  Default 값은 10000000 (10MB).
                 MaxDechunkSize = 10000000,

# HTL, HTH 사이 통신용으로 사용하는 socket 의 버퍼크기를 설정한다.
# 단위는 바이트.  Default 값은 0 (OS default) 이다.
                 HtlHthSendSocketBufferSize = 0,
                 HtlHthRecvSocketBufferSize = 0

# HTMLS, CGIS, PHPS, SSIS 서버와 client 사이의 flow control 작동방식을 결정한다.
# Y 설정: 기존 작동방식 사용.  Client 가 느리게 응답을 읽을경우 서버가 주기적으로 client 상태를
#         검사한다 (1초에 한번).  이방식을 사용하면 전송속도가 예상외로 느려질수있다.
# N 설정: 새로운 작동방식 사용.  주기적 검사를 사용하지않는다.
# Default 값은 Y.
                 UseOldServerFlowControl = Y

# HTH 내장 HTMLS 기능 사용 결정.  내장 HTMLS 는 HTMLS 서버가 제공하는 기능중 가장 많이 사용되는
# static file 전송, conditional GET (range 요청제외) 많을 처리한다.
# Y 설정: 사용한다.  자세한 작동방식은 추가 설정을 통해서 결정한다.
# N 설정: 사용하지 않는다.
# Default 값은 N.
                 UseInternalHTMLS = N,

# 다음 설정들은 HTH 내장 HTMLS 작동방식을 결정한다.  UseInternalHTMLS = Y 일경우만 적용된다.
# InternalHTMLSReadSize 는 최대 read buffer 크기이다 (byte).
# Default 값은 16384.
                 InternalHTMLSReadSize = 16384,
# 응답이 InternalHTMLSMaxCacheSize 보다 작을경우 (byte), HTH cache 에 삽입한다.
# Default 값은 8192.
                 InternalHTMLSMaxCacheSize = 8192,
# 응답이 InternalHTMLSAsyncReadThreshold 보다 클경우 HTH 내부의 worker thread 를 사용해서 파일을 읽는다.
# Default 값은 32768.
                 InternalHTMLSAsyncReadThreshold = 32768,
# InternalHTMLSAsyncReadThreads 가 worker thread 개수를 결정한다.
# Default 값은 16.
                 InternalHTMLSAsyncReadThreads = 16,
# Sendfile 을 지원하는 버전은 응답이 InternalHTMLSSendfileThreshold 보다 크면 sendfile 을 사용해서
# 응답을 전송한다.  SSL 연결은 sendfile 을 사용할수없다.
# Default 값은 0 (사용하지 않음).
                 InternalHTMLSSendfileThreshold = 0

# 요청한 파일을 찾지 못했을 경우, CheckURLFrom에서 CheckURLTo로 character encoding을 변환하여 다시 찾아보게 한다.
# Default 값은 N.
                 CheckURL = Y,
# Unix/Linux에서는 CheckURL = Y로 설정한 경우, 항상 CheckURLTo를 설정해야한다.
# Windows에서는 CheckURL = Y로 설정한 경우, CheckURLTo는 "ACP"가 default이며, code-page identifier로 설정할 수 있다.
# CheckURLTo/From값으로 Windows에서 사용할 수 있는 설정은 다음과 같다.
# "ACP"    Ansi code-page, system default를 사용
# "UTF-8"  UTF-8
# "<code-page identifier>" system에 설치된 code-page의 번호로 설정
#                          ex) "949" Korean
                 CheckURLTo = "EUC-KR",
                 CheckURLFrom = "UTF-8"  # default

#####
##### VHOST 절
#####
# WebtoB로 Virtual Hosting이 필요한 경우, 이에 대한 환경 설정을 한다. 
# Virtual Host 기능은 실제로는 하나의 WebtoB가 동작하지만, 
# 각기 다른 URL로 다른 문서를 제공하도록 함으로서, 
# 마치 여러 개의 Server가 서비스를 제공하는 것처럼 보이도록 하는 기능이다.
# 필수 항목으로 NodeName, HostName, DocRoot를 정의해야 한다.
*VHOST

# VHost의 이름을 지정한다.
vhost_full      

# Virtual Host가 속해있는 Node의 이름을 적어준다. 
# 이 Node 이름은 NODE 절에 정의되어 있어야 한다.
                NodeName = "WebServer",

# Virtual Host에 접근할 때 유저가 사용할 호스트 이름을 적어준다. 
# Name-based Virtual Hosting을 하는 경우 각각의 VHOST 절에서 호스트 이름을 다르게 정의한다. 
# 이 경우는 호스트 이름으로 Virtual Host가 구분된다.
                HostName = "vhost.tmax.co.kr",

# Virtual Host가 서비스하게 될 HTML문서가 있는 최상위 디렉토리 경로명을 설정한다.
                DocRoot="/data2/wbqam/webtob/docs/vhost_full",

# VHOST절의 선택 항목은 앞의 NODE절의 선택 항목 중 일부분이며 그 내용은 동일하다. 
# 단지 설정된 virtual host에 대해 재정의 된다. 
# 각 항목의 설명 및 설정값에 대해서는 NODE절을 참고하여 설정한다.
#                Port = "8540",
#                Listen = "192.168.1.43:8540",

##                SslFlag = Y,
##                SslName = "ssl_def",

#                Group = "nobody",
#                User = "nobody",

#                Admin = "vhost@tmax.co.kr",
#                AppDir = "/data2/wbqam/webtob/ap",
#                IndexName = "vindexname.html",
##                DirIndex = "diridx_ign",
#                ServiceOrder = "ext,uri",
#                DefaultCharset = "On",
#                DefaultMimetype = "application/octet-stream",
#                KeepAlive = Y,
#                KeepAliveTimeout = 10,
#                KeepAliveMax = 5,
#                Timeout = 5,
#                UserDir = "vpublic_html",
#                Options = "-CGI,-Index",
#                Logging = "log3",
#                ErrorLog = "log4",
#                ErrorDocument = "404",
#                Method = "GET,-POST,-HEAD,-OPTIONS",
#                Expires = "expdef1" 
#                HostAlias = "quality.tmax.co.kr,qa2.tmax.co.kr",

##### VHOST절의 설정의 예.
#vhost_def       
#                NodeName = "WebServer",
#                HostName = "192.168.1.43",
#                DocRoot = "/data2/wbqam/webtob/docs",
#                Port = "8510",
#                Logging = "log3",
#                ErrorLog = "log4"

#vhost_only      NodeName = "WebServer",
#                HostName = "192.168.1.43",
#                DocRoot = "/data2/wbqam/webtob/docs",
#                Port = "8520",
#                Logging = "log3",
#                ErrorLog = "log4",
#                DirIndex = "diridx_ign",
#                Options = "+Index",
#                KeepAlive = N

#vhost_ssl       NodeName = "WebServer",
#                HostName = "192.168.1.43",
#                DocRoot = "/data2/wbqam/webtob/docs",
#                Port = "8530",
#                Logging = "log3",
#                ErrorLog = "log4",
#                SslFlag = Y,
#                SslName = "ssl_def"


#####
##### SVRGROUP 절
#####
# WebtoB를 통해 응용 Server Process를 접근하는 경우 Server Process의 논리적인 연관성에 따라 
# 이들을 그룹으로 관리할 필요가 있게 된다. 
# 필수 항목으로 NodeName, SvrType 를 지정해야 한다.
*SVRGROUP

# Server Group에 대한 논리적인 이름으로써 SVRGROUP절 내에서 유일한 값이어야 한다.
# SVRGROUP절 이름은 SERVER 절의 SVGNAME 항목에서 사용된다.
htmlg_full      

# Server Group이 존재하는 Node를 정의한다. 
# 사용되는 NodeName은 NODE 절에서 정의한 Node 이름이어야 한다.
                NodeName = "WebServer", 

# Server Group의 속성, 즉 어떠한 서비스를 제공하는가를 명시한다. 
# SvrType으로 HTML, CGI, JSV, WEBSTD, SSI 중에 하나의 값을 선택하여야 한다.
                SvrType = HTML,

# Server Group이 Virtual Host에 속할 경우 해당 Virtual Host 이름을 적어준다.
#                VhostName = "vhost_only",

# WebtoB를 통해 응용 프로그램을 바로 호출하는 경우 해당 프로그램이 위치할 디렉토리를 설정한다. 
# 경로명은 절대 경로와 WEBTOBDIR을 기준으로 한 상대 경로를 사용할 수 있다.
                AppDir = "/data2/wbqam/webtob/ap/htmlg2/",

# 사용자 메시지가 기록될 Directory의 경로명을 설정한다. 
                UsrLogDir = "/data2/wbqam/webtob/log/usrlog/htmlg2/",

# WebtoB에서 특정 정보를 읽어 들일 필요가 있는 경우 이용된다.
#                EnvFile = "WebtoB.env",

# LOGGING절에서 설정하는 Logging Name을 설정하며, 해당 설정에 해당하는 Log를 남기게 되는 것이다.
                Logging = "log_htmlg2",

# php에 관련된 Server Group을 설정할 경우 php 실행 모듈이 실제로 존재하는 곳의 경로를 설정하는 항목이다. 
##                ScriptLoc = "/cgi-bin/php"

# php 경우 외부 php executable 을 사용하지않고 php 를 모듈형식으로 로드할수있다.
# UseSAPI=Y 로 설정하면 php 모듈을사용한다.  기본값은 N 이다.
# Y 로 설정한경우, 모듈 경로를 SapiModulePath 에 반드시 설정해야한다.
# 추가적으로 php 가 사용할 php ini 파일경로를 SapiIniPath 에 설정할수있다.
#                UseSAPI=Y,
#                SapiModulePath="libphp5.so",
#                SapiIniPath="php.ini",

# HTTP header의 Content-Type에 character set 설정이 없는 Request에 응답에 추가될 character set의 이름을 설정한다.
# "On"(ISO-8859-1), "Off"(설정안함), "_charset_"(사용자 기술) 중 하나를 설정할 수 있다.
# 여러 절에서 적용되는 우선 순위는 Node < Vhost < SvrGroup < Directory 순이다.
#                DefaultCharset = "On",

# MIME-Type을 결정할 수 없는 문서의 Default Content-Type을 설정한다. 
# Default Content-Type은 SvrGroup, Vhost, Node절의 순으로 결정된다
#                DefaultMimeType = "application/jsp",

# EXPIRES절의 설정한 Expires이름을 설정한다.
#                Expires = "expdef1",

# AUTHENT절에서 설정한 이름을 명시하면 된다.
# 인증(Authentication)을 적용할 수 있다
#                AuthentName = "auth_def"

# Multi Node 환경에서 부하분산을 위해서 반드시 설정해 주어야 하는 항목이다. 
# 다른 그룹 이름을 지정해 주면 그룹별로 서로 서버 프로세스를 공유하게 되어 
# 지정한 그룹에는 서버 프로세스를 등록하지 않아도 해당 프로세스가 서비스를 처리할 수 있게 된다. 
# 같은 Node이거나 다른 Node에 있는 그룹인 경우 모두 연속하여 지정 할 수 있다.
##                Cousin = "htmlg3",

# Multi Node 환경에서 Cousin 설정시 부하 분산 방법을 지정한다.
# 지정 가능한 값은 1 ~ 256 이다.
# 0 일경우 Dynamic Load Balancing을 의미하며, 
# 한 노드에서 더이상의 사용자를 처리할 여력이 없을때 다른 노드에서 처리 한다.
##                Load = 2

# Multi Node 환경에서 백업 서버그룹을 지정하는 항목이다.
# 장애시 중단 없이 서비스를 할 수 있게 장애시 백업 되어야 할 그룹 이름을 지정한다.
##                Backup = "backsvg"

##### SVRGROUP절의 설정의 예.
#htmlg_def       NodeName = "WebServer", 
#                SvrType = HTML

#htmlg_auth      NodeName = "WebServer", 
#                SvrType = HTML,
#                AuthentName = "auth_def"

#webapg_def      NodeName = "WebServer", 
#                SvrType = WEBSTD

#cgig_def        NodeName = "WebServer", 
#                SvrType = CGI

#jsvg_def        NodeName = "WebServer", 
#                SvrType = JSV

#phpg_def        NodeName = "WebServer", 
#                SvrType = PHP,
#                ScriptLoc = "/cgi-bin/php"

#ssig_def        NodeName = "WebServer", 
#                SvrType = SSI

##### MultiNode 구성을 위한 SVRGROUP절의 설정의 예.
#mainsvg         NodeName = "WebServer", 
#                SvrType = HTML,
#                Backup = "backsvg"

#backsvg         NodeName = "tmaxi1", 
#                SvrType = HTML

#htmlg1          NodeName = "WebServer", 
#                SvrType = HTML,
#                Cousin = "htmlg3",
#                Load = 2

#htmlg3          NodeName = "tmaxi1", 
#                SvrType = HTML,
#                Load = 1

#####
##### SERVER 절
#####
# WebtoB에서 제공하는 서비스들을 등록한다.
# WebtoB가 제공하는 대부분의 서비스는 SERVER 절에서 등록이 가능하며,
# 비즈니스 로직을 WebtoB를 통해 직접 호출하는 경우에만 SERVICE 절의 등록이 필요하다. 
# 필수 항목으로는 SvgName을 지정해야 한다.
*SERVER

# Server의 실행 파일 이름으로써 일반적으로 Server 이름은 유일(Unique) 해야 한다.
html_full       

# Server가 속해 있는 Server Group을 정의한다.
                SvgName = htmlg_full,

# 특정 vhost 용으로 서버를 사용할경우, vhost 이름을 설정한다.
# Server group 도 vhost 이름을 설정할수있다.  Server 와 server group 모두에 vhost 이름이 설정되어있는 경우,
# 이름이 일치해야한다.
#               VhostName = vhost1,

# Server Process가 기동 될 때 그 Server Process로 전달되는 명령어 옵션이 있을 경우 이 항목에서 정의할 수 있다. 
# 정의된 옵션들 중에 '--' 이전에 지정된 옵션들은 시스템에서 사용하고, 
# 그 이후에 지정된 옵션들은 사용자가 자유롭게 사용할 수 있다.
                Clopt = "-o html_full.out -e html_full.err",

# 기본적으로 기동 될 Server Process의 개수를 결정한다.
                MinProc = 2,

# MinProc를 포함하여 추가적으로 기동 시킬 수 있는 Process의 최대 개수이다.
                MaxProc = 10,

# 사용자 메시지가 기록될 Directory의 경로명을 설정한다. 
                UsrLogDir = "/data2/wbqam/webtob/log/usrlog/html_full/",

# 큐에 적체된 Client의 요구수가 어느 정도 이상이 되면 
# 새로 도착한 요구는 큐에 적체되지 않고 Client에 즉시 에러로 응답할 수 있도록
# 큐에 적체 할 요구 한계를 설정한다.
#                MaxQCount = 2,

# 큐에 적체된 Client의 요구수가 어느 정도 이상이 되면 
# 새로 도착한 요구는 큐에 적체하지 않고 redirect 응답을 보낸다.
# 이 설정을 통해 다른 서버에서 요청을 처리하거나, Max Queue 상태임을 표시하는 페이지를 보여줄 수 있다.
# 단, 이 경우 redirect 되는 서버가 같은 서버일 경우 무한히 redirect될 수 있다.
#                MaxQUrl = "/err/maxq.html",

# 자동으로 Server Process가 추가 기동 되기 위한 조건으로 큐에 쌓여진 요구 개수를 정의한다. 
# 즉, 이 큐에 설정된 이상의 것이 적체되면 MinProc에서 MaxProc에 설정된 수만큼 차례대로 증가하게 된다.
#                AsQCount = 1

# 특수한 Server Process에서 HTH Process와 병렬 통신 채널 수를 결정하는 항목이다. 
# Server Process의 처리량이 아주 많아 하나의 채널로는 처리속도가 저하될 때 병렬 통신으로 처리 속도를 증가시킬 수 있다.
#                SvrCPC = 4, 

# SERVER절에 각 server에 정의된 MaxRequests값에 따라, 
# 각 server의 프로세서들이 그 값만큼의 사용자 request를 처리한 후, auto-rebooting된다.
# 0으로 설정시 제한을 하지 않는다.(unlimited)
# default 설정은 0 이다. 
#                MaxRequests = 5,

# 서버프로세스의 최대 재시작 가능 횟수를 결정한다.
#                MaxRestart = 2,

# Server에서 사용자의 요청에 response를 보낼 때 사용하는 버퍼의 크기를 설정한다.
# default 설정은 4096 이다.
                HttpOutBufSize = 2048,

# Server에 사용자의 request를 받을 때 사용하는 버퍼의 크기를 설정한다.
# default 설정은 8192 이다.
                HttpinBufSize = 4096,

# Request를 처리할 Server Process를 지정하는 방법을 지정한다.
# RR : Round Robin방식으로 Idle한 Server Processor에 요청을 할당한다.
# FA : First Assign방식으로 우선순위(index)가 높고 Idle한 Server Process에 요청을 할당한다.
# default 설정은 RR 이다.
                Schedule = FA,

# 서버와의 연결이 정상인지 확인하기 위해 체크하는 시간을 설정하며 
# 방화벽을 사이에 두고 연결된 JEUS 와의 연결을 확인하는 데 사용된다.
                SvrChkTime = 5,

# JSV (JEUS) 서버인경우 session routing 용으로 사용되는 session ID key 이름을 설정한다.
# Default = "JSESSIONID"
                SessionIdCookieKey = "MySessionId",

# 지정된 Content-Type 의 응답을 GZIP 압축한다.
# 한개이상의 Compression= 을 사용하면 여러개의 Content-Type 을 지정할수있다.
# Default = 압축하지않음.
                Compression = "text/html",
                Compression = "text/plain",

# 해당 서버에 적용된 옵션을 설정한다.
# {+|-}Cache : Content의 Cache 유무를 결정한다. 현재 SvrType이 HTML인 서버에만 지원된다.
# BlockListen : Server가 서비스 불능 상태가 되면, 더이상의 클라이언트를 받아들이지 않도록 WebtoB는 Port Listen을 중단한다.
# NotifyClientClose : JSV (JEUS) 서버인경우 client 가 연결을 끊으면 JSV 연결도 함께 끊는다.
# default 설정은 none 이다.
                Options = "-Cache,BlockListen",

# FastCGI 관련 설정 (CGI 서버).
#
# FcgiInitEnv 를 사용해서 FastCGI application 을 실행할때 환경변수를 추가할수있다.   
# 포맷은 NAME=VALUE.
                FcgiInitEnv = "LOGFILE=d:/wb-413/log/iip.log",
# FastCGI application process 가 시작한후 지정한 시간이 지나면 CGI 서버가 요청처리후 process 를 강제로 종료한다.
# FcgiKillTimeOut 단위는 second.  0 은 무제한을 의미한다.
                FcgiKillTimeOut = 600,
# FastCGI application process 가 시작한후 처리한 요청수 가 지정한 개수를 초과하면 CGI 서버가
# process 를 강제로 종료한다. 0 은 무제한을 의미한다.
                FcgiKillMaxRequest = 100

##### SERVER절의 설정의 예.
#html_def        SvgName = htmlg_def

#html_auth       SvgName = htmlg_auth

#html_cpc        SvgName = htmlg_def,
#                SvrCPC = 4

#html_nocache    SvgName = htmlg_def,
#                MinProc = 2,
#                HttpOutBufSize = 0,
#                HttpInBufSize = 0,
#                Options = "-Cache"
##               UriDir = "/uri/exclusive"

#svr_def         SVGNAME = webapg_def

#cgi_def         SVGNAME = cgig_def

#MyGroup_def     SvgName = jsvg_def,
#                MinProc = 5, MaxProc = 10

#php_def         SvgName = phpg_def

#ssi_def         SvgName = ssig_def

##### MultiNode 구성을 위한 SERVER절의 설정의 예.
#html_failover   SVGNAME = mainsvg,      
#                MinProc = 2, 
#                MaxProc = 10,
#                Options = "-Cache"

#html_load       SVGNAME = htmlg1,
#                MinProc = 2, 
#                MaxProc = 10,
#                Options = "-Cache"

######
###### SERVICE 절
######
# WebtoB를 통해 비즈니스 로직을 바로 수행할 경우에만 설정이 필요하다.
# 필수 항목으로 SvrName을 지정해야 한다.
*SERVICE

# WebtoB를 통해 바로 수행시키고자 하는 비즈니스 로직에 해당하는 
# Server프로그램 내의 함수 이름 (Service 루틴명)을 명시한다.
# 15자 이내로 SERVICE절 내에서 고유한 이름이어야 한다.
#svc_def

# 해당 Service를 제공하는 Server Process를 지정한다.
                SvrName = svr_def,

# Client 요구를 처리하는 우선순위 값을 설정한다.
# 1 ~ 50 사이의 값을 지정할 수 있으며, 숫자가 높을수록 높은 우선순위르르 갖는다.
                Priority = 10,

# Service 처리의 제한 시간이다. 
# 지정된 SvcTime 시간내에 처리를 못하면 에러를 내보낸다.
                SvcTime = 5

#####
##### DIRECTORY 절
#####
# Node내의 특정 Directory의 속성을 지정한다.
# 필수 항목으로 Directory를 지정해야 한다.
*DIRECTORY

# DIRECTORY절에서 유일한 이름을 지정한다.
dir_full       

# 속성을 지정할 Directory의 경로명을 설정한다.
                Directory = "/data2/wbqam/webtob/docs/directory/dir_full", 

# HTTP header의 Content-Type에 character set 설정이 없는 Request에 응답에 추가될 character set의 이름을 설정한다.
# "On"(ISO-8859-1), "Off"(설정안함), "_charset_"(사용자 기술) 중 하나를 설정할 수 있다.
# 여러 절에서 적용되는 우선 순위는 Node < Vhost < SvrGroup < Directory 순이다.
                DefaultCharset = "kr",

# MIME-Type을 결정할 수 없는 문서의 Default Content-Type을 설정한다. 
# Default Content-Type은 SvrGroup, Vhost, Node절의 순으로 결정된다
                DefaultMimeType = "text/html",

# 디렉토리 안의 모든 리소스들를 ForceMimetype에 설정한 Mimetype으로 처리하게 한다.
                ForceMimeType = "text/html",

# Virtual Host가 속해있는 Node의 이름을 적어준다. 
# 이 Node 이름은 NODE 절에 정의되어 있어야 한다.
                NodeName = "WebServer"

# Virtual Host를 이용하게 구성된 환경에서 DIRECTORY에 대한 설정을 
# 해당 Virtual Host에만 적용되도록 설정을 해야 할 필요가 있을 때 가능한 설정이다.
#               VHostName = "vhost_only"

# DIRECTORY 절에 대해서 인증(Authentication)을 적용할 수 있다.
# 단, 서버타입이 JSV인 경우 SVRGROUP에만 인증을 적용할 수 있다.
##                AuthentName = "auth_def"

# ACCESS절의 설정한 이름을 지정한다.
# AccessName에 설정된 규칙에 따라 Access를 제한할 수 있다.
##                AccessName = "access_allow"

# DIRECTORY 절에 적용될 옵션을 설정할 수 있다.
                Options = "+Cache"

##### DIRECTORY절의 설정의 예.
#dir_def         DIRECTORY = "/data2/wbqam/webtob/docs/directory/dir_def"
#dir_auth        DIRECTORY = "/data2/wbqam/webtob/docs/directory/dir_auth", 
#                AuthentName = "auth_def"
#dir_access      DIRECTORY = "/data2/wbqam/webtob/docs/directory/dir_access", 
#                AccessName = "access_allow"
#dir_noaccess    DIRECTORY = "/data2/wbqam/webtob/docs/directory/dir_noaccess", 
#                AccessName = "access_deny",
#                VHostName = "vhost_only"
#dir_mixed       DIRECTORY = "/data2/wbqam/webtob/docs/directory/dir_mixed", 
#                AccessName = "access_mixed"

#####
##### URI 절
#####
# URI Section은 Client 요구의 URI(Uniform Resource Identifier)값에 따라 
# 이를 처리하는 서비스를 구분할 수 있도록 한다. 
# URI절은 CGI를 이용하는 경우에 많이 이용된다. 
# 필수 항목으로 Uri, SvrType 를 지정해야 한다.
*URI

# Uri 이름을 지정한다.
uri_full        

# 서비스 속성을 지정할 URI 값을 지정한다.
                Uri = "/uri/full/",

# URI 에 설정된 패턴은 기본적으로 request URL 의 prefix 로 사용된다.
# Prefix 외 exact matching, fn matching, regular expression matching 도 사용가능하다.
# Match 에 사용하고 싶은 방식을 설절하면 된다.
# 설정가능 값: prefix, exact, fn, regexp
# Default 값은 prefix 이다.
#               Match = "exact",

# 지정된 URI를 포함하는 Request가 왔을 때 이를 처리할 Server를 지정한다. 
                SvrType = HTML,

# 처리를 담당할 Server의 이름을 지정한다
                SvrName = html_def,

# 처리를 전담할 Service의 이름을 지정한다.
#                SvcName = "",

# Multi Node로 구성된 환경에서 
# NodeName이 설정된 URI는 해당 노드에만 적용된다.
#                NodeName = "WebServer",

# 특정 Vhost에 대한 URI를 설정하거나 
# Vhost마다 URI는 동일하나 다른 SVRTYPE을 쓰고싶을 때 지정한다.
#                VHostName = "vhost_only"
#
# 같은 URI 를 하나이상의 Vhost 에 적용하고싶은 경우, 여러개의 Vhost 이릉을 설정할 수 있다.
# 이때 이름들은 comma 로 구별한다.  이름이 많은 경우 VhostName 을 여러번 설정하면 된다.
#                VhostName="vhost1, vhost2",
#                VhostName="vhost3"

# 지정 URI에 대한 요구를 다른 URI에 Mapping 시키고자 할때 지정한다. 
#                Redirect = ""

# Redirect 기능 사용시 발생될 http status 설정한다. 
# 이 값은 http response의 Location header에 설정되어 사용자에게 보내진다.
#                RedirectStatus = permanent,

# URI 절에 대해서 인증(Authentication)을 적용하고자 할대 설정한다.
#                AuthentName = "auth_def"

# URI절에 적용될 옵션을 설정한다.
                Options = "-Cache,SSLDenySSL",

# SvrType = CGI 인 경우, 요청이 SCGI 인지 결정한다.  SCGI = Y 로 설정하면,
# 추가적으로 SCGI 서버 주소도 함께 설정해야 한다.
                SCGI = N,

# SCGI 서버 주소를 설정한다.  형식은 "서버이름/IP 주소:port 번호".
                ScgiServer="server21:11112",

# SvrType = CGI 인 경우, 요청이 FastCGI 인지 결정한다.
                FCGI = N


##### URI절의 설정의 예.
#uri_cgi         Uri = "/cgi-bin/", 
#                SvrType = CGI

#uri_wbapi       Uri = "/svct/", 
#                SvrType = WEBSTD

#uri_jsv         Uri = "/examples/", 
#                SvrType = JSV

#uri_php         Uri = "/uri_php/", 
#                SvrType = PHP

#uri_ssi         Uri = "/uri_ssi/", 
#                SvrType = SSI

#uri_exclusive   Uri = "/uri/exclusive/", 
#                SvrType = HTML,
#                SvrName = html_nocache

#uri_redirst     Uri = "/uri/redirect/", 
#                SvrType = HTML, 
#                Redirect = "/uri/redirect3/",
#                RedirectStatus = permanent,
#                VHostName = "vhost_only"

#uri_redir       Uri = "/uri/redirect/", 
#                SvrType = HTML, 
#                Redirect = "/uri/redirect2/"

#uri_auth        Uri = "/uri/auth/",
#                SvrType = HTML,
#                AuthentName = "auth_def"

#uri_access      Uri = "/uri/access/",
#                SvrType = HTML,
#                AccessName = "access_allow"

#uri_noaccess    Uri = "/uri/noaccess/",
#                SvrType = HTML,
#                AccessName = "access_deny",
#                VHostName = "vhost_only"

#uri_svgauth     Uri = "/uri/svgauth/",
#                SvrType = HTML,
#                SvrName = html_auth

#####
##### ALIAS 절
#####
# Server 안의 물리적 디렉토리 경로와 URI를 Alias시키도록 설정할 수 있다. 
# 이는 사용자가 Document root에 상관없이 지정할 수 있기 때문에 
# 관리하는 입장에서 매우 편리할 것이다.
# 필수 항목으로 Uri, RealPath를 지정해야 한다.
*ALIAS

# Alias 이름을 지정한다.
ali_full        

# Alias 시키고자 하는 URI를 지정한다.
                Uri = "/ali_full/", 

# Server 안의 물리적 Directory의 경로명을 지정한다.
                RealPath = "/data2/wbqam/webtob/docs/",

# Alias가 실행될 때 이를 수행할 Server의 Type을 지정한다.
                SvrType = HTML,

# Alias 절이 적용되는 Node를 지정한다.
                NodeName = "WebServer",

# Alias 절이 적용되는 Virtual Host를 제한하고 싶을 때 명시한다.
                VhostName = "vhost_only"

##### ALIAS절의 설정의 예.
#ali_def         Uri = "/ali_def/",
#                RealPath = "/data2/wbqam/webtob/docs/alias/"
#ali_cgi         Uri = "/cgi-bin/",
#                RealPath = "/data2/wbqam/webtob/cgi-bin/"

#####
##### DIRINDEX 절
#####
# 요청 주소가 디렉토리까지만 명시된 디렉토리 구조를 보여줄 수 있도록 설정할 수 있다.
# DIRINDEX절을 사용하기 위해서 NODE절에서 Options = "+Index", DirIndex = "DirIndex_Name"
# 설정을 해야 한다.
# 필수 항목으로 Options를 지정해야 한다.
*DIRINDEX

# DirIndex 이름을 지정한다.
diridx_full     

# Options
# {+|-}Fancy 옵션
#   WebtoB가 제공하는 Fancy Indexing을 on/off로 설정할 수 있다.
#   Fancy Indexing은 filename, last-modified, filesize별로 정렬하는 링크를 보여주는 기능이다.
# {+|-}EncodeURL 옵션
#   생성된 페이지 내부의 URL중 Non-ASCII에 대한 URL-encoding 사용을 결정한다.
#   -EncodeURL로 설정할 경우 한글파일의 link를 한글 그대로 보이게 되며,
#   브라우저 설정에 따라 해당 파일이 Not Found가 될 수 있기 때문에 주의해야 한다.
# Default 설정 = Fancy, EncodeURL
                Options = "Fancy, EncodeURL",

# 표시하고 싶지 않은 파일들이 Index 리스트에 나타나지 않도록 해준다. 
# Description, HeaderFile, TailFile에 설정된 항목을 보이고 싶지 않을경우 설정하면 유용하다.
                Ignore = "desc, header.html, tail.html, *.bak",

# 특정한 파일에 대한 Description을 설정한다.
# description file에 대한 설정이며,
# docroot로 부터 절대경로로 설정하거나, 현재 directory로부터 상대경로로 설정할 수 있다.
#
# description file은 파일이름과 그 파일에 대한 설명을 공백으로 구분하여 한줄씩 적으면 되고,
# 파일에 공백이 있다면 "sample file.txt" 처럼 ""로 감싸주면 된다.
# 줄의 시작이 '#'이면 그 줄은 무시한다.
#
# Description 설정이 상대경로일 경우 파일이름만 적어야 하며,
# Description 설정이 절대경로일 경우 파일이름도 절대경로로 적어야 한다.
                Description = "desc",

# Indexing의 Header를 지정된 파일에서 읽어 온다.
                HeaderFile = "header.html",

# Indexing의 TailFile을 지정한 파일에서 읽어 온다.
                TailFile = "tail.html",

# Unknown File Type에 대한 Icon을 설정한다.
# Node나 VHost의 IconDir 설정을 기준으로 한다.
                DefaultIcon = "icon.ico",

# 파일의 extension 값에 따라 그에 맞는 Icon으로 Indexing을 할 수 있도록 설정한다. 
# 즉, Icon 파일의 URL과 파일 확장자를 매칭시킨다.
# 예를 들어 IconExt = "gif"로 설정하면
# 파일이 sample.html 이고, html.gif가 IconDir에 있을 경우 html.gif를 보여준다.
# 만약 html.gif가 IconDir에 없다면 DefaultIcon이 보일 것이다.
                IconExt = "gif",

##### DIRINDEX절의 설정의 예.
#diridx_def      Options = "Fancy"
#diridx_ign      Options = "Fancy",
#                Ignore = "*.gif"

#####
##### LOGGING 절
#####
# Client의 요구 내역을 기록하는 형식을 지정한다. 
# 접근 내역과 에러 내역이 따로 저장되며 저장 형식을 지정할 수 있다.
# LOGGING절을 사용하기 위해서는 NODE절에 Logging, ErrorLog 등의 설정이 필요하다.
# 필수 항목으로 FileName, Format를 지정해야 한다.
*LOGGING

# Log 이름을 지정한다.
log1            

# 로그를 저장할 파일의 경로명과 파일 이름을 설정한다.
# 상대 경로 ("/" 로 시작하지 않는 경로) 는 "WEBTOBDIR/상대경로" 로 자동 대체한다.
# 파일 이름에 포함된 다음 string 은 파일 생성시 실제값으로 대체됩니다.
# %Y% = year (4 digits)
# %M% = month (2 digits)
# %D% = day (2 digits)
# %h% = hour (2 digits)
# %m% = minute (2 digits)
# %s% = second (2 digits)
                FileName = "log/access_%Y%%M%%D%.log", 

# Log File에 기록될 내용과 기록 방식을 지정한다. 
# Format를 지정하지 않을 경우 WebtoB의 default 로그 파일 형식이 사용 된다.
# WebtoB에서 미리 정의해 놓은 포맷으로 DEFAULT, ERROR 두가지를 제공한다.
                Format = "DEFAULT", 

# Logging 방식의 Option을 지정한다.
# "Sync" 옵션을 주면 Log를 메모리에 버퍼링하지 않고 바로 기록한다.
                Option = "Sync",

# 지정된 확장자를 가진 요청 파일에대해서 log 를 남기자않는다.
# Default = ""
                ExcludeByExt = "jpg,png",

# 새로운 log message 생성시 현재 존재하는 log file 이 지정된 시간보다
# 오래되면 새로운 log file 을 만든다.  단위는 초.
# Default = 적용하지 않음.
                RotateBySeconds = 10000,

# 새로운 log message 생성시 현재 존재하는 log file 에 쓰여진 log message
# 개수가 지정된 값보다 만을경우, 새로운 log file 을 만든다.
# Default = 적용하지 않음.
# RotateByEntries 는 더이상 사용하지 않음.
#                RotateByEntries = 1000000

# ArchiveFileName 을 설정하면 로그 파일 변환시 (log rotation) 같은 파일 이름을 유지할 수 있다.
# ArchiveFileName 이 설정된경우, 현재 로그 파일이 설정된 이름으로 옴겨진다.  그리고
# 새로운 로그 파일이 FileName 에 설정대로 생성된다.  Default 값은 "" (empty string).
#
# 예) 현재 사용되는 로그 파일은 언제나 log/access.log 이며, 주기적으로 
# log/backup.access_20090425_112233.log 등으로 옴겨진다.
#                 ArchiveFileName="log/backup/access_%Y%%M%%D%_%h%%m%%s%.log"
#                 FileName = "log/access.log", 


##### LOGGING절의 설정의 예.
#log2            Format = "ERROR", 
#                FileName = "/data2/wbqam/webtob/log/error_%Y%%M%%D%.log", 
#                Option="sync",
#log3            Format = "DEFAULT", 
#                FileName = "/data2/wbqam/webtob/log/vaccess_%Y%%M%%D%.log", 
#                Option="sync",
#log4            Format = "ERROR", 
#                FileName = "/data2/wbqam/webtob/log/verror_%Y%%M%%D%.log", 
#                Option="sync",
#log_htmlg2      Format = "DEFAULT", 
#                FileName = "/data2/wbqam/webtob/log/htmlg2_%Y%%M%%D%.log"
#syslog          Format = "SYSLOG", 
#                FileName = "/data2/wbqam/webtob/log/syslog/syslog_%Y%%M%%D%.log"

#####
##### AUTHENT 절
#####
# Client의 접근을 제한하기 위한 인증과정을 유저와 그룹 단위로 통제할 수 있도록 설정가능하며 
# SVRGROUP, URI, EXT, DIRECTORY 절에 설정되어 인증 과정을 거칠 수 있다.
# 필수 항목으로 Type, UserFile을 지정해야 한다.
*AUTHENT

# Authent 이름을 지정할 수 있다.
auth_def        

# Authorization control (인가 제어) 방식을 설정한다. 
# Basic: HTTP Basic authentication.
# Digest: HTTP Digest authentication.
                Type = Basic,

# Authorization을 위한 사용자, 암호, realm 이 기록되는 파일을 지정한다.
# 이 파일은 wsmkpw 를 사용하여 생성한다.
                UserFile = "/data2/wbqam/webtob/config/passwd"

# Authorization을 그룹단위로 실행하기 위해 사용자명과 암호명을 기록하는 파일을 
# 따로 지정할 필요가 있을 때 사용된다. 
#                GroupFile = ""

#####
##### SSL 절
#####
# WebtoB에서 사용할 SSL의 기능을 설정한다.
# 필수 항목으로 CertificateFile, CertificateKeyFile을 지정해야 한다.
*SSL

# Ssl 이름을 지정한다.
ssl_full        

# 이것은 PEM 방식으로 인코딩된 서버의 인증서이다.
                CertificateFile = "/data2/wbqam/webtob/ssl/newcert.pem",

# 서버에서 쓰이는 PEM 방식으로 인코딩된 인증서의 개인키를 지정한다. 
                CertificateKeyFile = "/data2/wbqam/webtob/ssl/newcert.pem",

# 인증서를 저장할 디렉토리를 지정한다.
                CACertificatePath = "/data2/wbqam/webtob/ssl/",

# 단일 CA로 부터의 사용자 인증만 받고 싶을 경우에 지정한다.
                CACertificateFile = "/data2/wbqam/webtob/ssl/client.pem",

# 얼마나 깊은 레벨로 연결된 CA들을 추적하여 인증할 것인지를 지정한다.
                VerifyDepth = 10,

# 사용자에게 요청할 인증 레벨을 설정한다.
# 0: 아무런 인증 요청을 하지 않는다.
# 1: 사용자는 사용 가능한 인증을 서버에게 보여 주어야 한다.
# 2: 사용자는 사용 가능한 인증을 반드시 서버에게 보여 주어야 한다.
# 3: 사용자는 사용 가능한 인증을 보여 주어야 하며 
#    만일 서버가 인증서를 가지고 있지 않은 상황에서는 인증서 인증 과정이 필요 없다.
                VerifyClient = 1,

# 한줄짜리 사용자 이름을 배제한 기본 인증 과정을 통해서 마치 인증한 것처럼 보여 준다.
                FakeBasicAuth = Y,

# SSL에서 이용할 Random Seed를 위한 파일을 지정한다.
                RandomFile = "/data2/wbqam/webtob/bin/.rnd, 2048",

# RandomFile을 설정할 때 실제 각 SSL을 통한 연결을 맺을 때
# 몇 개의 파일을 이용하여 Random Seed를 만들 것인지 결정하는 것이다.
                RandomFilePerConnection = "/data2/wbqam/webtob/bin/.rnd, 512",

# 서버 인증서(Certificate)의 인증서 연쇄(Certificate Chain)를 구성할 때 필요한, 
# 상위 인증기관들(CAs)의 인증서(certificate) 경로를 설정한다. 
# 단, Client의 인증 (authentication)사용하기 위해서는 
# CACertificateFile이나, CACertificatePath에 설정해야 한다.
                CertificateChainFile = "/data2/wbqam/webtob/ssl/chain.pem",

# SSL 사용시에 암호화된 개인키(encrypted private key) 파일들에 대한 
# 암호문을 얻기위한 방식을 설정하는 항목이다.
# "exec: <progname>"	    : progname의 stdout의 값을 PassPhrase 값으로 사용한다.
# "file: <ppd-filename>"    : wsmkppd utility를 이용하여 만들어지 ppd-file에서
#			      sslname값으로 저장된 PassPhrase값을 얻는다.
                PassPhraseDialog = "exec:/pass.sh",

# SSL external Crypto Device의 종류를 설정한다.
# 설정 가능한 값은 "builtin", "cswift" 두가지 이며, 
# default 설정은 "builtin" 이다.
                CryptoDevice = "builtin"

##### SSL절의 설정의 예.
#ssl_def         CertificateFile="/data2/wbqam/webtob/ssl/newcert.pem",
#                CertificateKeyFile="/data2/wbqam/webtob/ssl/newcert.pem",
#                PassPhraseDialog="exec:/data2/wbqam/webtob/pass.sh"

#####
##### EXT 절
#####
# Client가 요구한 파일의 확장자명에 따라 처리 담당 Process를 지정할 수 있다. 
# WebtoB는 기본적인 모든 MIMETYPE에 대한 처리 담당 Process가 설정되어 있으나, 
# 필요에 따른 추가적인 설정을 할 경우 설정 한다.
# 필수 항목으로 MimeType, SvrType를 지정해야 한다.
*EXT

# Ext 이름을 지정한다.
ext_full        

# 처리하고자 하는 MimeType를 지정한다.
                MimeType = "text/html", 

# 요구를 처리할 Server 타입을 지정한다.
                SvrType = HTML,

# 특정한 Server가 처리하게 하려면 Server의 이름을 지정한다.
                SvrName = "html_def",

# 특정한 서비스가 처리하도록 설정할 경우 서비스의 이름을 설정한다.
                Routing = "svc_def",

# 멀티노드 환경에서 EXT절에 대한 설정을 특정 노드에만 적용하고자 할 경우
# 해당 노드이름을 지정한다.
# 지정하지 않은 경우에는 모든 노드에 적용된다.
                NodeName = "WebServer",

# 특정 Virtual Host에만 적용하고자 할 경우 Virtual Host 이름을 지정한다.
# 지정하지 않을 경우에는 모든 Virtual Host에 적용된다.
#               VHostName = "vhost_only",
# 같은 EXT 를 하나이상의 Vhost 에 적용하고싶은 경우, 여러개의 Vhost 이릉을 설정할 수 있다.
# 이때 이름들은 comma 로 구별한다.  이름이 많은 경우 VhostName 을 여러번 설정하면 된다.
#                VhostName="vhost1, vhost2",
#                VhostName="vhost3"

# 인증(Authentication)을 적용하고자 AUTHENT절에서 설정한 이름을 지정한다.
# 단, 서버타입이 JSV인 경우 SVRGROUP에만 인증을 적용할 수 있다.
                AuthentName = "auth_def"

# 적용될 옵션을 설정할 수 있다.
# "+Cache", "-Cache", "SSLRequireSSL", "SSLDenySSL", "UnSet" 을 지정할 수 있다.
                Options = "+Cache,SSLDenySSL",

# URI 절의 SCGI 참조.
                SCGI = N,

# URI 절의 ScgiServer 참조.
                ScgiServer = "server21:11112",

# URI 절의 FCGI 참조.
                FCGI = N

# EXT 에 설정된 패턴은 기본적으로 exact matching 을 사용한다.  이 외 prefix matching, regular expression
# matching 도 사용가능하다.  Match 에 사용하고 싶은 방식을 설절하면 된다.  Regular expression 을 사용하려면
# 패턴을 RegExp 에 별도로 설정해야 한다.
# 설정가능 값: prefix, exact, regexp
# Default 값은 exact 이다.
#               Match = "exact",

# Regular expression 사용시 패턴을 설정한다.
#               RegExp = "jsp.*"

##### EXT절의 설정의 예.
#htm             MIMETYPE = "text/html", SVRTYPE = HTML
#html            MIMETYPE = "text/html", SVRTYPE = HTML
#jsp             MIMETYPE = "application/jsp",  Svrtype=JSV
#php             MIMETYPE = "application/x-httpd-php3", SVRTYPE = PHP
#auth            MIMETYPE = "text/html", SVRTYPE = HTML,
#                AuthentName = "auth_def"
#access          MIMETYPE = "text/html", SVRTYPE = HTML, 
#                AccessName = "access_deny"
#jsp             Options = "UnSet"

#####
##### ACCESS 절
#####
# Client의 IP address나 network/netmask 들을 기준으로 요청의 허용/제한을 설정하고, 
# 요청 허용/제한이 적용되는 순서를 설정할 수 있다. 
# Access 절은 URI/EXT/DIRECTORY/TCPGW 절에 적용될 수 있다.
*ACCESS

# Access 이름을 지정한다.
access_mixed    

# Allow와 Deny가 적용되는 순서를 설정한다.
                Order = "allow,deny", 

# 요청이 허용되는 IP address나 network/netmask들을 설정한다.
                Allow = "192.168.1.43/255.255.255.0",

# 요청이 거절되는 IP address나 network/netmask들을 설정한다.
                Deny = "192.168.1.43/255.255.255.0"

##### ACCESS절의 설정의 예.
access_allow    Order = "allow,deny", 
                Allow = "192.168.1.43/255.255.255.0"
access_deny     Order = "deny,allow", 
                Deny = "all"

#####
##### EXPIRES 절
#####
# 클라이언트 요청에 따라 전송되는 서버응답 헤더의 정보를 설정한다.
# 특정 Mimetype 문서 전송시 서버응답 헤더내에 전송되는 문서의 expiry date를 설정한다.
# 필수 항목으로 ExpiresTime를 지정해야 한다.
*EXPIRES

# string으로 Expires의 이름을 설정한다.
expdef1         

# 2가지 방법으로 Expiry Date를 명시할 수 있다.
                ExpiresTime = "modification 1 days",

# Response MIME type에 따라 Expiry Date를 설정할 수 있다.
# <code><seconds>, <base> [plus] {<num> <type>}
                MimeType = "text/html",

# Request URL에 따라 Expiry Date를 설정할 수 있다.
                Url = "/exp/"

##### EXPIRES절의 설정의 예.
exp11           MimeType = "image/gif", 
                ExpiresTime = "A2419200"
exp12           MimeType = "image/jpeg", 
                ExpiresTime = "access plus 1 months"

#####
##### TCPGW 절
#####
# NODE절에 설정하여 특정 port나 IP로 들어오는 Client Request를 처리할 server에 관해 설정한다. 
# 설정된 port를 listen하고 있다 data가 오면 그 data를 그대로 설정된 서버로 분배한다.
# 필수항목으로 Port 혹은 Listen, ServerAddress를 지정해야 한다.
*TCPGW

# TCPGW의 이름을 지정한다.
tcpgw_full      

# Client의 Request를 Listen하는 Port를 설정한다.
# 여러개를 동시에 지정가능하다. (100개)
                Port = "4949", 

# Client의 Request를 Listen하는 IP Address와 Port를 설정한다.
# 여러개를 동시에 지정가능하다. (100개)
                #Listen = "192.168.1.43:4949"

# Client의 Request를 처리 할 서버들의 IP Address와 Port를 설정한다.
# 여러개를 동시에 지정가능하다. (100개)
# 설정된 서버들간의 분배규칙은 Round Robin만 지원한다.
                ServerAddress = "192.168.1.43:8100,192.168.1.43:8540",

# 사용자가 Request 후, 해당 서버로부터 지정된 시간동안 응답이 없는 경우, 
# 접속을 종료하기 위한 시간을 설정할 수 있다.
# 0 이면 Disable 이며, Default 값은 300 이다.
                TimeOut = 30,

# Client의 Request를WebtoB TCP Gateway가 받아서, 설정된 상대 서버로 접속을 시도할 때, 
# 일정시간 동안 접속 요구에 대한 응답이 없으면, 다른 서버로 재분배 되도록 시간을 설정할 수 있다.
# 0 이면 Disable 이며, Default 값은 5 이다.
                ConnectTimeout = 10,

# 접속가능하지 않은 서버를 매번 요청때마다 접속 유무를 확인하는 대신에 
# 처음 서버가 접속가능하지 않으면 다음 분배에서 제외하고 
# CheckAliveTime 간격으로 해당서버의 접속유무를 확인하여 다음 분배에서 제외 유무를 결정하게 된다.
# 0 의 값은 기존의 방식처럼 매번 요청때 마다 서버의 접속가능 유무를 확인하게 된다.
# Default 값은 0 이다.
                CheckAliveTime = 15,

# ACCESS 절의 ACCESS name에 설정된 규칙에 따라 사용자 접속의 허용 여부를 결정한다.
                AccessName = access_allow

##### TCPGW절의 설정의 예.
#tcpgw_def       Port = "4747", 
#                ServerAddress = "192.168.1.43:8100"
#tcpgw_listen    Listen = "192.168.1.43:4848",
#                ServerAddress = "192.168.1.43:8100",
#                CheckAliveTime = 15

#####
##### ERRORDOCUMENT 절
#####
*ERRORDOCUMENT
404             Status = 404, Url = "/404.html"

#####
##### Reverse proxy 절
#####
# Reverse proxy 는 일반 HTTP proxy 와 유사한 역할을한다.  Client 로 부터온 요청을
# 내부의 서버로 전달하고, 내부 서버로 부터온 응답을 client 로 전달한다.
# 일반 HTTP proxy 와는 다르게 Reverse proxy 는 다음 추가기능을 수행한다.
# 1. 요청의 request URL 을 수정한후 내부 서버로 전달한다.
#    이외에 X-Forwarded-For, X-Forwarded-Host, X-Forwarded-Server header field 가
#    추가된다.
# 2. 서버 응답의 Location, Content-Location, Cookie header field 와 HTML URL 을 수정한후
#    client 로 전달한다.
*REVERSE_PROXY

# Reverse proxy 의 이름을 지정한다.
rproxy1

# Reverse proxy 가 속하는 NODE 의 이름.
                NodeName = "WebServer",

# Reverse proxy 가 속하는 VHOST 의 이름.
                VhostName = "vhost1",

# Request URL 이 지정된 string 으로 시작하면 해당요청을 reverse proxy 로 처리한다.
                PathPrefix = "/internal/",

# 요청이 전달되는 내부 서버주소
                ServerAddress = "internal-server:80",

# Request URL 의 PathPrefix 에 해당하는 부분이 여기서 지정된 string 으로 교체된후,
# 수정된 요청이 배부 서버로 (ServerAddress) 전달된다.
# 예) /internal/abc.html => /docs/abc.html
                ServerPathPrefix = "/docs/",

# 내부 서버 응답의 status code 가 301, 302, 303, 307 일 경우 (redirect)
# Location, Content-Location header field 의 absolute URL 을 수정한다.
# RewriteRedirect 는 흰공백 (whitespace) 로 두개의 string 으로 나누어진다.
# 첫째는 (http://internal-server:80/docs/) 원본 응답의 Location, Content-Location
# 의 URL 과 비교된다.  URL 이 정해진 string 으로 시작하면 URL 이 수정된다.
# URL host 부분은 요청에 사용된 host, port 로 전환되고, URL path 부분은
# 두 번째 string 으로 교체된다.
# 예)    Location: http://internal-server:80/docs/abc.html
#     => Location: http://webtob:8100/internal/abc.html
                RewriteRedirect = "http://internal-server:80/docs/ /internal/",

# 내부 서버 응답의 Cookie header field 값의 domain= 를 수정한다.
# domain= 에 지정된 domain string 이 여기에 지정된 string 과 일치할경우
# domain= 을 요쳥에 사용된 domain 으로 교체한다.
# 예)    Cookie: ... domain=internal-server
#     => Cookie: ... domain=webtob
                RewriteCookieDomain = "internal-server",

# 내부 서버 응답의 Cookie header field 값의 path= 를 수정한다.
# path= 에 지정된 string 이 여기에 지정된 첫 번째 string 으로 시작할경우
# 두 번째 string 으로 교체한다.
# 예)    Cookie: ... path=/jeus/application
#     => Cookie: ... path=/jeus_proxy/application
                RewriteCookiePath = "/jeus /jeus_proxy",

# 내부 서버 응답이 HTML 인 경우 (Content-Type: text/html), HTML 문서의
# URL 을 수정한다.  URL 을 포함하는 tag, attribute 은 HtmlUrl 을
# 사용하여 정의한다.  다음 meta tag 의 content 는 예외로 항상 URL 을
# 포함한다고 가정한다.
# <meta ... http-equiv="refresh" ... content="http://internal-server:80/docs/link3.html" ...>
#
# URL 이 밑에 설정된 첫 번째 string 으로 시작하면,
# 해당하는 부분이 두 번째 string 으로 교체된다.  URL host 가 있을경우, host 는
# 요청에 사용된 WebtoB 주소로 교체된다.
                RewriteHtmlUrl = "http://test2:80/ /apache_proxy/",
                RewriteHtmlUrl = "/ /apache_proxy/",

# HTML 문서내부의 URL 을 포함하는 tag, attribute 이름을 정한다.
# 첮 string 은 tag name 이고, 두번째 부터는 attribute 이름을 정한다.
                HtmlUrl = "a href",
                HtmlUrl = "img src longdesc usemap",

# HTML URL 수정을 위해 HTML 응답 전체를 WebtoB 내부 메모리에 저장한다.
# 이용도로 사용되는 메모리 버퍼의 최대크기를 설정한다.  단위: Byte.
# 응답이 지정된 값보다 큰경우는 HTML URL 이 수정되지 않는다.
# Default = 10240
                RewriteHtmlMaxSize = 4194304

#####
##### LOGLEVEL 절
#####
# Syslog 메시지출력을 제어하는 로그레벨을 설정하는 절이다.
#
# 로그 레벨이 TRACE 인경우 메시지는 syslog 파일에 저장되지않고, 환경변수 WEBTOB_TRACE 에 설정된 파일 (TRACE 파일) 에 저장된다.
# WEBTOB_TRACE 이 설정되어 있지않으면 $(WEBTOBDIR)/log/trace/processname-pid-date.trace
# 에 저장된다.  WEBTOB_TRACE 는 %N%, %P%, %D% 와 같은 format string 을 사용할수있다.
# %N% = process 이름
# %P% = PID
# %D% = date
# 예) WEBTOB_TRACE = %N%.trace 로 설정되면, HTH 메시지는 HTH.trace, CGIS 메시지는 CGIS.trace 에 저장된다.
*LOGLEVEL

# Logger 이름을 설정한다.  Logger 는 WebtoB 하나의 구성요소에 해당된다.  이름은 hierarchy 로 되어있으며,
# 현재 정의된 이름들은 다음과 같다.
# .               : Root 을 의미한다.  모든 구성요소를 포함한다.
# .hth            : HTH
# .htl            : HTL
# .wsm            : WSM
# .server         : 모든 서버들을 포함한다. 
# .server.htmls   : HTMLS
# .server.cgis    : CGIS 
# .server.phps    : PHPS
# .server.ssis    : SSIS
# .server.filters : FILTERS
.hth

# 로그 레벨을 설정한다.  메시지의 레벨일 설정된 값이상이면 출력된다.
# 정의된 레벨은 "TRACE", "DEBUG", "INFO", "WARN", "FATAL" 이다.
# TRACE 가 가장 낮은 레벨이며 WebtoB 4.1.3 이전의 debug binary 메시지를 출력한다.
# Default 값은 INFO 이다.
                Level = "INFO"

# .hth 는 추가적으로 서버와 client 가 주고 받는 메시지를 출력할 수 있다.
# 다음 내가지의 option 을 comma 로 구별해서 설정하면 된다.
# dcR=client 가 보낸 데이타 출력
# dcW=client 로 전송된 데이타 출력
# dsR=server 가 보낸 데이타 출력
# dsW=server 로 전송된 데이타 출력
# Default 값은 "" (empty string).
#               Options="dcR,dcW,dsR,dsW"
#
# 서버와 client 메시지들은 syslog 파일이 아닌 TRACE 파일에 저장된다.
