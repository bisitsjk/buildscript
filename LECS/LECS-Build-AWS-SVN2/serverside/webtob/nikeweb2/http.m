*DOMAIN
webtob1

*NODE
nikeweb2        WEBTOBDIR="/usr2/webtob",
                SHMKEY = 54000,
                DOCROOT="/lotte/lecs/NK2233/web",
                PORT = "80",
                HTH = 1,
                #Group = "nobody",
                #User = "nobody",
                NODENAME = "$(NODENAME)",
                ERRORDOCUMENT = "503",
                JSVPORT = 9900,
                IPCPERM = 0777,
                LOGGING = "log1",
                ERRORLOG = "log2",
                SYSLOG = "log3"

*VHOST
v_nikestore     DOCROOT="/lotte/lecs/NK2233/web",
                NODENAME = nikeweb2,
                HOSTNAME = "www.nikestore.co.kr",
                HOSTALIAS = "121.254.239.20",
                PORT = "80",
                ServiceOrder="ext,uri",
                LOGGING = "log1_nikestore",
                ERRORLOG = "log2_nikestore"

*SVRGROUP
htmlg           NODENAME = "nikeweb2", SVRTYPE = HTML
nikestoreg      NODENAME = "nikeweb2", SVRTYPE = JSV, VhostName = v_nikestore

*SERVER
html            SVGNAME = htmlg,        MinProc = 30, MaxProc = 30
nikestore       SVGNAME = nikestoreg,   MinProc = 60, MaxProc = 60

*URI
#uri1           Uri = "/cgi-bin/",   Svrtype = CGI

*ALIAS
#alias1         URI = "/cgi-bin/", RealPath = "/usr2/webtob/cgi-bin/"

*LOGGING
log1            Format = "DEFAULT", FileName = "/usr2/webtob/log/access.log_%M%%D%%Y%", Option = "sync"
log2            Format = "ERROR", FileName = "/usr2/webtob/log/error.log_%M%%D%%Y%", Option = "sync"
log3            Format = "SYSLOG", FileName = "/usr2/webtob/log/system.log_%M%%D%%Y%", Option = "sync"
log1_nikestore  Format = "DEFAULT", FileName = "/usr2/webtob/log/nikestore-access.log_%M%%D%%Y%", Option = "sync"
log2_nikestore  Format = "ERROR", FileName = "/usr2/webtob/log/nikestore-error.log_%M%%D%%Y%", Option = "sync"

*ERRORDOCUMENT
503                     status = 503,
                        url = "/503.html"

*EXT
htm          MimeType = "text/html", SvrType = HTML
jsp          MimeType = "application/jsp", SVRTYPE = JSV
do           MimeType = "application/do", SVRTYPE = JSV
lecs         MimeType = "application/lecs", SVRTYPE = JSV
html         MimeType = "text/html", SVRTYPE = HTML
bin          MimeType = "application/octet-stream", SVRTYPE = HTML
zip          MimeType = "application/octet-stream", SVRTYPE = HTML
cab          MimeType = "application/octet-stream", SVRTYPE = HTML
exe          MimeType = "application/octet-stream", SVRTYPE = HTML
js           MimeType = "application/x-javascript", SVRTYPE = HTML
css          MimeType = "text/css",  SVRTYPE = HTML
jpeg         MimeType = "image/jpeg", SVRTYPE = HTML
jpg          MimeType = "image/jpeg", SVRTYPE = HTML
jpe          MimeType = "image/jpeg", SVRTYPE = HTML
jfif         MimeType = "image/jpeg", SVRTYPE = HTML
pjpeg        MimeType = "image/jpeg", SVRTYPE = HTML
pjp          MimeType = "image/jpeg", SVRTYPE = HTML
bmp          MimeType = "image/bmp",  SVRTYPE = HTML
txt          MimeType = "text/plain", SVRTYPE = HTML
mpeg         MimeType = "zvideo/mpeg", SVRTYPE = HTML
mpg          MimeType = "video/mpeg", SVRTYPE = HTML
mpe          MimeType = "video/mpeg", SVRTYPE = HTML
mpv          MimeType = "video/mpeg", SVRTYPE = HTML
vbs          MimeType = "video/mpeg", SVRTYPE = HTML
mpegv        MimeType = "video/mpeg", SVRTYPE = HTML
avi          MimeType = "video/msvideo", SVRTYPE = HTML
shtml        MimeType = "magnus-internal/parsed-html",   SVRTYPE = HTML
bat          MimeType = "magnus-internal/cgi", SVRTYPE = HTML
gif          MimeType = "image/gif", SVRTYPE = HTML
ppt          MimeType = "application/vnd.ms-powerpoint", SVRTYPE = HTML
pdf          MimeType = "application/pdf", SVRTYPE = HTML
swf          MimeType=  "application/x-shockwave-flash", SVRTYPE = HTML
ocx          MimeType = "application/x-pe-win32-x86", SVRTYPE = HTML
