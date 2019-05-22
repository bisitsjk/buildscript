 import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NTCredentials;
import org.apache.commons.httpclient.auth.AuthScope;
import org.apache.commons.httpclient.methods.GetMethod;
import groovy.swing.SwingBuilder
import java.awt.BorderLayout as BL
import java.awt.Color
import java.text.SimpleDateFormat
import java.util.*



if (args.length == 0){
	println "Give me Target"
	return
}

def TARGET = args[0]


def RULES = [
	dev:[
		rss:"http://ceres.lotte.com/NBP/_layouts/listfeed.aspx?List=9def62bc%2Dc18d%2D401c%2D91e3%2D7089390c2033&View=4379d55a%2Dfa76%2D4bf8%2D8008%2D86b392adfe07",
		filter:"신청",
		dirFilter: { title -> 
			title.startsWith(new Date().format("MMdd")+"_오전")
		},
	],

	stg:[
		rss:"http://ceres.lotte.com/NBP/_layouts/listfeed.aspx?List=9def62bc%2Dc18d%2D401c%2D91e3%2D7089390c2033&View=eb937c2e%2Dcdf0%2D4aed%2D96cd%2D2323af343fbe",		
		"filter":"개발확인",
		"remains":"개발 배포됨",
		"dirFilter": { title -> 
			title.startsWith(args.length == 1 ? new Date().format("MMdd")+"_오전": args[1])
		}
	],
		
	"prd":[
		"rss":"http://ceres.lotte.com/NBP/_layouts/listfeed.aspx?List=9def62bc%2Dc18d%2D401c%2D91e3%2D7089390c2033&View=3b190664%2D39a5%2D4023%2Daf55%2D3778820f4af0",
		"filter":"스테이지확인", 
		"remains":"스테이지 배포됨",
		"dirFilter": { title -> 
			title.startsWith(args[1])
		}
	],
	"prd_re":[
		"rss":"http://ceres.lotte.com/NBP/_layouts/listfeed.aspx?List=9def62bc%2Dc18d%2D401c%2D91e3%2D7089390c2033&View=3b190664%2D39a5%2D4023%2Daf55%2D3778820f4af0",
		"filter":"운영 배포됨", 
		"remains":"-----",
		"dirFilter": { title -> 
			title.startsWith(args[1])
		}
	],
]

def 배포디렉토리RSS = "http://ceres.lotte.com/NBP/_layouts/listfeed.aspx?List=d125335f%2D01a8%2D44a4%2Dbb79%2D711bed920007&View=25ef57a5%2D4826%2D4b23%2D8a4a%2Dea3a64793a4f"



HttpClient client = new HttpClient();
NTCredentials creds = new NTCredentials("naru","naru","ceres.lotte.com","ceres.lotte.com");
client.getParams().setAuthenticationPreemptive(true);
client.getState().setCredentials(AuthScope.ANY, creds);

wget = { url ->
	def method = new GetMethod(url);
	client.executeMethod(method)
	return method
}


wgetString = { url ->
	def method = new GetMethod(url);
	client.executeMethod(method)
	return new String(method.getResponseBody(), "UTF-8")
}
wgetRSS = { url ->
	def html = wgetString(url)
	return html.substring(html.indexOf("<rss"))
}


def 대상_폴더  = ((new XmlSlurper().parseText(wgetRSS(배포디렉토리RSS))).channel.item*.title*.toString().find(RULES[TARGET]["dirFilter"]))

println 대상_폴더



String html = wgetRSS(RULES[TARGET]["rss"]);


class 배포요청  {
	def 제목;
	def 요청자;
	def id;
	def timestamp
	Map properties = new HashMap()
	
	
	public String toString() {
		return id+","+요청자+","+properties["배포요청파일명"];
	}
}



def parseId = { item ->
	(item.link =~ /ID=([^&]*)/ )[0][1]
}

def parseDescription = { req, desc -> 
	
	def text = '<html>'+desc.text()+"</html>"

	dom = new XmlSlurper(new org.ccil.cowan.tagsoup.Parser()).parseText(text)
	
	dom.body.div*.each { 
		def paired =it.text()  
		key = (paired =~ /([^:]*):(.*)/ )[0][1].trim()
		value = (paired =~ /([^:]*):(.*)/ )[0][2].trim()
		req.properties[key] = value
	}
}




rss = new XmlSlurper().parseText(html)


items = rss.channel.item*.collect{ item ->
	println item.pubDate
	def req = new 배포요청()
	req.id = parseId(item) 
	req.제목 = item.title
	req.요청자 = item.author
	req.timestamp = item.pubDate
	parseDescription(req, item.description)
	
	return req
}

all = items*.collect { it.properties["id"] = it.id; return it.properties }.collect {it[0]}
println "ALL"
all.each { item ->
	println "\t${item}"
}


작업요청목록 = all.findAll{ it["진행상태"] ==  RULES[TARGET]["filter"] }.collect {it}
remains = all.findAll{ it["진행상태"] ==  RULES[TARGET]["remains"] }.collect {it}

println 작업요청목록
println "--------------------"
println remains



대상시스템 = 작업요청목록.collect { it["대상시스템"]}  as HashSet

workDir= new File("${TARGET}/${new Date().format('yyyyMMdd_HHmmss')}");
if (workDir.exists()){
	workDir.deleteDir()
}

workDir.mkdirs()
println "Work Dir: ${workDir}"



downloadAll = { item ->

	def fileName = item["배포요청파일명"]
	println fileName
	def path = URLEncoder.encode(대상_폴더,"UTF-8")
	def encodedFileName = URLEncoder.encode("${fileName}","UTF-8")
	
	def url =  "http://ceres.lotte.com/NBP/02/${path}/${encodedFileName}"
	println url
	method = wget(url)

	println "Status Code: ${method.getStatusCode()}"
	if (method.getStatusCode() == 200){
		println "Save to ${fileName}"
		new File(workDir, fileName).leftShift(method.getResponseStream())
	}
}

new File(workDir,"rss.xml").setText('<?xml version="1.0" encoding="UTF-8"?>'+html, "UTF-8")

작업요청목록.each(downloadAll)


def f = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss z", Locale.US)
def timestamp = f.parse(rss.channel.lastBuildDate.toString())



println "반영요청서 수집 시간: ${timestamp.format('yyyy.MM.dd HH:mm:ss')}"
println "배포대상 시스템: "+(작업요청목록.collect { item ->
	return item.대상시스템
} as Set)

println "배표요청 목록"
작업요청목록.each { item -> 
	println "Ceres ID:${item.id}"
	println " 개발요청자:${item.개발요청자}"
	println " 배포요청파일명:${item.배포요청파일명}"
	println " 대상시스템:${item.대상시스템}"
	println " 진행상태: ${item.진행상태}"
	println " 내용 : ${item.개발내용}"
	println ""
}
println ""


/*
count = 0;
new SwingBuilder().edt {
	frame(title:"",size:[800,600], show:true) {
		vbox {
			panel {
				lineBorder(color:Color.BLACK, thickness:3)
				borderLayout()
				textlabel = label(text:"대상 시스템", constraints: BL.NORTH)
				list (	listData : 대상시스템, constraints: BL.CENTER)
			}
			panel {
				borderLayout()
				textlabel = label(text:"Click the button!2", constraints: BL.CENTER)
			}
			panel {
				borderLayout()
				textlabel = label(text:"Click the button!3", constraints: BL.CENTER)
			}
		}

	}
}


*/