*DOMAIN
webtob1

*NODE
boweb1        WEBTOBDIR="/usr2/webtob",
                SHMKEY = 54000,
                DOCROOT="/lotte/lecsDocs/contents/bo",
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
v_lecs_ssl      DOCROOT="/lotte/lecsDocs/contents/bo",
                NODENAME = boweb1,
                HOSTNAME = "bo.lecs.com",
                HOSTALIAS = "121.254.239.26",
                PORT = "443",
                ServiceOrder="ext,uri",
                LOGGING = "log1_lecs_ssl",
                ERRORLOG = "log2_lecs_ssl",
                SslFlag = Y,
                SSLNAME = "lecsssl"

*SSL
lecsssl		CertificateFile = "/usr2/webtob/ssl/secure_bolecs.pem",
                CertificateKeyFile = "/usr2/webtob/ssl/secure_bolecs.pem",
               	CACertificateFile = "/usr2/webtob/ssl/secureCA.pem",
                CACertificatePATH = "/usr2/webtob/ssl/",
                PassPhraseDialog = "exec:     /usr2/webtob/ssl/.SSL_KEY_PASSWORD_LECSSL",
                RandomFile = "/tmax/webtob/bin/.rnd, 2048",
                RandomFilePerConnection = "/tmax/webtob/bin/.rnd, 512",
                VerifyClient = 0,
                VerifyDepth = 10,
                FakeBasicAuth = Y

*SVRGROUP
htmlg          NODENAME = "boweb1", SVRTYPE = HTML
lecssslg       NODENAME = "boweb1", SVRTYPE = JSV, VhostName = v_lecs_ssl

*SERVER
html           SVGNAME = htmlg,    MinProc = 30, MaxProc = 30, HttpInBufSize=1024000, HttpOutBufSize=1024000
lecsssl        SVGNAME = lecssslg, MinProc = 60, MaxProc = 60, HttpInBufSize=1024000, HttpOutBufSize=1024000

*URI
#uri1           Uri = "/cgi-bin/",   Svrtype = CGI

*ALIAS
#alias1         URI = "/cgi-bin/", RealPath = "/usr2/webtob/cgi-bin/"

*LOGGING
log1                    Format = "DEFAULT", FileName = "/usr2/webtob/log/access.log_%M%%D%%Y%", Option = "sync"
log2                    Format = "ERROR", FileName = "/usr2/webtob/log/error.log_%M%%D%%Y%", Option = "sync"
log3                    Format = "SYSLOG", FileName = "/usr2/webtob/log/system.log_%M%%D%%Y%", Option = "sync"
log1_lecs_ssl           Format = "DEFAULT", FileName = "/usr2/webtob/log/ssl/lecs-access.log_%M%%D%%Y%", Option = "sync"
log2_lecs_ssl           Format = "ERROR", FileName = "/usr2/webtob/log/ssl/lecs-error.log_%M%%D%%Y%", Option = "sync"

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
