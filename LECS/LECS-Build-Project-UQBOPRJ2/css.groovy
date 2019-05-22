import java.io.*

dir = args[0]
println "args[0] = ${args[0]}"
targetDir = args[1]
println "args[1] = ${args[1]}"
if (new File(targetDir).exists()==false){
	new File(targetDir).mkdirs()
}
prefix = args[2] //"http://imagedev.mujikorea.net/"
println "prefix = ${prefix}"
scheme = args[3]
println "scheme = ${scheme}"
if (prefix.endsWith("/") == false) {
    prefix = prefix +"/";
}

//println "/rule/conect_recycle.gif".replaceAll(/^\//, prefix)
//println "'../image/customer/bg_snbS.gif'".replaceAll(/\.\.\/image\//,  prefix)
//return
convert = { url -> 
	orig = url
	println "orig = ${orig}"
	url = url.replaceAll("'",  "")
	println "url 1 = ${url};
	url = url.replaceAll(/\.\.\/image\//,  "/")
	println "url 2 = ${url};
	url = url.replaceAll(/\.\.\/images\//,  "/")
	println "url 3 = ${url};
	url = url.replaceAll(/\/image\//,  "/")
	println "url 4 = ${url};
	url = url.replaceAll(/\/images\//,  "/")
	println "url 5 = ${url};
	url = url.replaceAll(/\.\.\/img\//,  "/")
	println "url 6 = ${url};
	url = url.replaceAll(/\.\.\/\.\.\/img\//,  "/")
	println "url 7 = ${url};
	url = url.replaceAll(/\.\.\/\.\.\/\.\.\/img\//,  "/")
	println "url 8 = ${url};
	url = url.replaceAll(/\/\//,  "/")
	println "url 9 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 10 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 11 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 12 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 13 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 14 = ${url};
	url = url.replaceAll(/\.\.\//,  "")
	println "url 15 = ${url};
	url = url.replaceAll(/MJ001/,  "")
	println "url 16 = ${url};
	url = url.replaceAll(/http:\/\/[^\/]+/, prefix)
	println "url 17 = ${url};
	
	if (url.startsWith("http") == false && url.startsWith("/") ==false){
		url = prefix+"/"+url
	}

	url = url.replaceAll(/^\//, prefix)
	println "url 18 = ${url};

	
	
	url = url.replaceAll(/\/\//, "/")
	println "url 19 = ${url};
	if (prefix.contains("http")){
		url = url.replaceAll(/http:\/\//, "http://")
		println "url 19 = ${url};		
	}
	
	if (scheme.contains("https")){
		url = url.replaceAll(/http:/, "https:")
		println "url 20 = ${url};			
	}
	

	println "Convert: $orig  -->  $url"
	return url
}

new File(dir).eachFileRecurse {  cssFile ->
	if (cssFile.name =~ /.*\.css/) {
		println "cssFile.name = ${cssFile.name};
		def relativePath = cssFile.absolutePath.substring(new File(dir).absolutePath.length())
		println "relativePath = ${relativePath};
		println "Source CSS: $cssFile.absolutePath"

		// handle exclude list
		if (cssFile.name.contains("screen.css")){
			return;
		}
		txt = cssFile.getText();
		println "txt 1 = ${txt};
		res = ""
		txt.split("\n").each { line ->
			m = line  =~ /([-:\/a-zA-Z0-9_\.]+\.([gG][iI][fF]|[jJ][pP][gG]|[pP][nN][gG]))[^a-zA-Z0-9]+/
			println "m = ${m};
			if ( m.find()){
				imageUrl = m.group(1)
				println "imageUrl = ${imageUrl};
				res += line.substring(0, m.start(1))
				res += convert(imageUrl)
				res += line.substring(m.end(1))+"\n"
			}
			else {
				res += line+"\n"
				println "res = ${res};
			}
		}
		f = new File(targetDir+"/"+relativePath);
		println "f = ${f};
		if (f.getParentFile().exists()==false){
			f.getParentFile().mkdirs();
		}
		f.write(res,"UTF-8")
		println "Target Path: $f.absolutePath"
//		cssFile.write(res, "UTF-8")
	}
}
