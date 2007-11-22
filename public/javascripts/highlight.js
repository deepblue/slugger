var dp={sh:{Toolbar:{},Utils:{},RegexLib:{},Brushes:{},Strings:{AboutDialog:"<html><head><title>About...</title></head><body class=\"dp-about\"><table cellspacing=\"0\"><tr><td class=\"copy\"><p class=\"title\">dp.SyntaxHighlighter</div><div class=\"para\">Version: {V}</p><p><a href=\"http://www.dreamprojections.com/syntaxhighlighter/?ref=about\" target=\"_blank\">http://www.dreamprojections.com/syntaxhighlighter</a></p>&copy;2004-2007 Alex Gorbatchev.</td></tr><tr><td class=\"footer\"><input type=\"button\" class=\"close\" value=\"OK\" onClick=\"window.close()\"/></td></tr></table></body></html>"},ClipboardSwf:null,Version:"1.5.1"}};
dp.SyntaxHighlighter=dp.sh;
dp.sh.Toolbar.Commands={ExpandSource:{label:"+ expand source",check:function(A){return A.collapse
},func:function(B,A){B.parentNode.removeChild(B);
A.div.className=A.div.className.replace("collapsed","")
}},ViewSource:{label:"view plain",func:function(B,A){var D=dp.sh.Utils.FixForBlogger(A.originalCode).replace(/</g,"&lt;");
var C=window.open("","_blank","width=750, height=400, location=0, resizable=1, menubar=0, scrollbars=0");
C.document.write("<textarea style=\"width:99%;height:99%\">"+D+"</textarea>");
C.document.close()
}},CopyToClipboard:{label:"copy to clipboard",check:function(){return window.clipboardData!=null||dp.sh.ClipboardSwf!=null
},func:function(B,A){var D=dp.sh.Utils.FixForBlogger(A.originalCode).replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&amp;/g,"&");
if(window.clipboardData){window.clipboardData.setData("text",D)
}else{if(dp.sh.ClipboardSwf!=null){var C=A.flashCopier;
if(C===null){C=document.createElement("div");
A.flashCopier=C;
A.div.appendChild(C)
}C.innerHTML="<embed src=\""+dp.sh.ClipboardSwf+"\" FlashVars=\"clipboard="+encodeURIComponent(D)+"\" width=\"0\" height=\"0\" type=\"application/x-shockwave-flash\"></embed>"
}}alert("The code is in your clipboard now")
}},PrintSource:{label:"print",func:function(B,A){var C=document.createElement("IFRAME");
var D=null;
C.style.cssText="position:absolute;width:0px;height:0px;left:-500px;top:-500px;";
document.body.appendChild(C);
D=C.contentWindow.document;
dp.sh.Utils.CopyStyles(D,window.document);
D.write("<div class=\""+A.div.className.replace("collapsed","")+" printing\">"+A.div.innerHTML+"</div>");
D.close();
C.contentWindow.focus();
C.contentWindow.print();
alert("Printing...");
document.body.removeChild(C)
}},About:{label:"?",func:function(A){var B=window.open("","_blank","dialog,width=300,height=150,scrollbars=0");
var C=B.document;
dp.sh.Utils.CopyStyles(C,window.document);
C.write(dp.sh.Strings.AboutDialog.replace("{V}",dp.sh.Version));
C.close();
B.focus()
}}};
dp.sh.Toolbar.Create=function(B){var D=document.createElement("DIV");
D.className="tools";
for(var A in dp.sh.Toolbar.Commands){var C=dp.sh.Toolbar.Commands[A];
if(C.check!=null&&!C.check(B)){continue
}D.innerHTML+="<a href=\"#\" onclick=\"dp.sh.Toolbar.Command('"+A+"',this);return false;\">"+C.label+"</a>"
}return D
};
dp.sh.Toolbar.Command=function(A,B){var C=B;
while(C!=null&&C.className.indexOf("dp-highlighter")==-1){C=C.parentNode
}if(C!=null){dp.sh.Toolbar.Commands[A].func(B,C.highlighter)
}};
dp.sh.Utils.CopyStyles=function(A,D){var B=D.getElementsByTagName("link");
for(var C=0;
C<B.length;
C++){if(B[C].rel.toLowerCase()=="stylesheet"){A.write("<link type=\"text/css\" rel=\"stylesheet\" href=\""+B[C].href+"\"></link>")
}}};
dp.sh.Utils.FixForBlogger=function(A){return(dp.sh.isBloggerMode==true)?A.replace(/<br\s*\/?>|&lt;br\s*\/?&gt;/gi,"\n"):A
};
dp.sh.RegexLib={MultiLineCComments:new RegExp("/\\*[\\s\\S]*?\\*/","gm"),SingleLineCComments:new RegExp("//.*$","gm"),SingleLinePerlComments:new RegExp("#.*$","gm"),DoubleQuotedString:new RegExp("\"(?:\\.|(\\\\\\\")|[^\\\"\"\\n])*\"","g"),SingleQuotedString:new RegExp("'(?:\\.|(\\\\\\')|[^\\''\\n])*'","g")};
dp.sh.Match=function(C,A,B){this.value=C;
this.index=A;
this.length=C.length;
this.css=B
};
dp.sh.Highlighter=function(){this.noGutter=false;
this.addControls=true;
this.collapse=false;
this.tabsToSpaces=true;
this.wrapColumn=80;
this.showColumns=true
};
dp.sh.Highlighter.SortCallback=function(B,A){if(B.index<A.index){return -1
}else{if(B.index>A.index){return 1
}else{if(B.length<A.length){return -1
}else{if(B.length>A.length){return 1
}}}}return 0
};
dp.sh.Highlighter.prototype.CreateElement=function(B){var A=document.createElement(B);
A.highlighter=this;
return A
};
dp.sh.Highlighter.prototype.GetMatches=function(D,C){var B=0;
var A=null;
while((A=D.exec(this.code))!=null){this.matches[this.matches.length]=new dp.sh.Match(A[0],A.index,C)
}};
dp.sh.Highlighter.prototype.AddBit=function(E,C){if(E===null||E.length===0){return 
}var D=this.CreateElement("SPAN");
E=E.replace(/ /g,"&nbsp;");
E=E.replace(/</g,"&lt;");
E=E.replace(/\n/gm,"&nbsp;<br>");
if(C!=null){if((/br/gi).test(E)){var A=E.split("&nbsp;<br>");
for(var B=0;
B<A.length;
B++){D=this.CreateElement("SPAN");
D.className=C;
D.innerHTML=A[B];
this.div.appendChild(D);
if(B+1<A.length){this.div.appendChild(this.CreateElement("BR"))
}}}else{D.className=C;
D.innerHTML=E;
this.div.appendChild(D)
}}else{D.innerHTML=E;
this.div.appendChild(D)
}};
dp.sh.Highlighter.prototype.IsInside=function(A){if(A===null||A.length===0){return false
}for(var B=0;
B<this.matches.length;
B++){var C=this.matches[B];
if(C===null){continue
}if((A.index>C.index)&&(A.index<C.index+C.length)){return true
}}return false
};
dp.sh.Highlighter.prototype.ProcessRegexList=function(){for(var A=0;
A<this.regexList.length;
A++){this.GetMatches(this.regexList[A].regex,this.regexList[A].css)
}};
dp.sh.Highlighter.prototype.ProcessSmartTabs=function(F){var B=F.split("\n");
var A="";
var G=4;
var D="\t";
function H(I,O,M){var N=I.substr(0,O);
var L=I.substr(O+1,I.length);
var J="";
for(var K=0;
K<M;
K++){J+=" "
}return N+J+L
}function E(I,K){if(I.indexOf(D)==-1){return I
}var L=0;
while((L=I.indexOf(D))!=-1){var J=K-L%K;
I=H(I,L,J)
}return I
}for(var C=0;
C<B.length;
C++){A+=E(B[C],G)+"\n"
}return A
};
dp.sh.Highlighter.prototype.SwitchToList=function(){var E=this.div.innerHTML.replace(/<(br)\/?>/gi,"\n");
var I=E.split("\n");
if(this.addControls==true){this.bar.appendChild(dp.sh.Toolbar.Create(this))
}if(this.showColumns){var A=this.CreateElement("div");
var C=this.CreateElement("div");
var B=10;
var D=1;
while(D<=150){if(D%B===0){A.innerHTML+=D;
D+=(D+"").length
}else{A.innerHTML+="&middot;";
D++
}}C.className="columns";
C.appendChild(A);
this.bar.appendChild(C)
}for(var D=0,H=this.firstLine;
D<I.length-1;
D++,H++){var G=this.CreateElement("LI");
var F=this.CreateElement("SPAN");
G.className=(D%2===0)?"alt":"";
F.innerHTML=I[D]+"&nbsp;";
G.appendChild(F);
this.ol.appendChild(G)
}this.div.innerHTML=""
};
dp.sh.Highlighter.prototype.Highlight=function(D){function F(I){return I.replace(/^\s*(.*?)[\s\n]*$/g,"$1")
}function G(I){return I.replace(/\n*$/,"").replace(/^\n*/,"")
}function B(O){var I=dp.sh.Utils.FixForBlogger(O).split("\n");
var N=new Array();
var L=new RegExp("^\\s*","g");
var K=1000;
for(var J=0;
J<I.length&&K>0;
J++){if(F(I[J]).length===0){continue
}var M=L.exec(I[J]);
if(M!=null&&M.length>0){K=Math.min(M[0].length,K)
}}if(K>0){for(var J=0;
J<I.length;
J++){I[J]=I[J].substr(K)
}}return I.join("\n")
}function E(I,K,J){return I.substr(K,J-K)
}var H=0;
if(D===null){D=""
}this.originalCode=D;
this.code=G(B(D));
this.div=this.CreateElement("DIV");
this.bar=this.CreateElement("DIV");
this.ol=this.CreateElement("OL");
this.matches=new Array();
this.div.className="dp-highlighter";
this.div.highlighter=this;
this.bar.className="bar";
this.ol.start=this.firstLine;
if(this.CssClass!=null){this.ol.className=this.CssClass
}if(this.collapse){this.div.className+=" collapsed"
}if(this.noGutter){this.div.className+=" nogutter"
}if(this.tabsToSpaces==true){this.code=this.ProcessSmartTabs(this.code)
}this.ProcessRegexList();
if(this.matches.length===0){this.AddBit(this.code,null);
this.SwitchToList();
this.div.appendChild(this.bar);
this.div.appendChild(this.ol);
return 
}this.matches=this.matches.sort(dp.sh.Highlighter.SortCallback);
for(var C=0;
C<this.matches.length;
C++){if(this.IsInside(this.matches[C])){this.matches[C]=null
}}for(var C=0;
C<this.matches.length;
C++){var A=this.matches[C];
if(A===null||A.length===0){continue
}this.AddBit(E(this.code,H,A.index),null);
this.AddBit(A.value,A.css);
H=A.index+A.length
}this.AddBit(this.code.substr(H),null);
this.SwitchToList();
this.div.appendChild(this.bar);
this.div.appendChild(this.ol)
};
dp.sh.Highlighter.prototype.GetKeywords=function(A){return"\\b"+A.replace(/ /g,"\\b|\\b")+"\\b"
};
dp.sh.BloggerMode=function(){dp.sh.isBloggerMode=true
};
dp.sh.HighlightAll=function(c,a,Z,U,I,B){function N(){var d=arguments;
for(var e=0;
e<d.length;
e++){if(d[e]===null){continue
}if(typeof (d[e])=="string"&&d[e]!=""){return d[e]+""
}if(typeof (d[e])=="object"&&d[e].value!=""){return d[e].value+""
}}return null
}function W(f,e){for(var d=0;
d<e.length;
d++){if(e[d]==f){return true
}}return false
}function P(e,j,d){var g=new RegExp("^"+e+"\\[(\\w+)\\]$","gi");
var h=null;
for(var f=0;
f<j.length;
f++){if((h=g.exec(j[f]))!=null){return h[1]
}}return d
}function T(h,e,g){var d=document.getElementsByTagName(g);
for(var f=0;
f<d.length;
f++){if(d[f].getAttribute("name")==e){h.push(d[f])
}}}function L(f){var d=document.getElementsByTagName("OL");
for(var e=0;
e<d.length;
e++){if(A(d[e].className,"code")){f.push(d[e])
}}}function F(e){var d=e.className.match(/lang_(.+)/);
if(d){return d[1]
}else{var f=M(e.innerHTML);
if(G(f)){return"xml"
}else{if(H(f)){return"cfamily"
}else{return 'ruby'
}}}}function G(d){return(d.indexOf("<")==0&&d.lastIndexOf(">")==d.length-1)
}function H(d){return d.lastIndexOf(";")==d.length-1||d.indexOf(";\r\n")!=-1||d.indexOf(";\n")!=-1||d.indexOf("}\n")!=-1||d.indexOf("}\r\n")!=-1
}function M(d){return d.replace(/(\n|\r)/gi, '').replace(/<[^\/]+?>/gi, '\n').replace(/<\/?[^>]+>/gi, '').replace(new RegExp("(^\\s*)|(\\s*$)", "g"), "");
}function A(g,f){var e=g.split(" ");
for(var d=0;
d<e.length;
d++){if(e[d]==f){return true
}}return false
}var J=[];
var b=null;
var Y={};
var K="innerHTML";
T(J,c,"pre");
T(J,c,"textarea");
L(J);
if(J.length===0){return 
}for(var D in dp.sh.Brushes){var S=dp.sh.Brushes[D].Aliases;
if(S===null){continue
}for(var R=0;
R<S.length;
R++){Y[S[R]]=D
}}for(var R=0;
R<J.length;
R++){var C=J[R];
var E=N(C.attributes["class"],C.className,C.attributes["language"],C.language);
var Q="";
if(E===null){continue
}E=E.split(":");
Q=E[0].toLowerCase();
if(!Q||Q=="code"){Q=F(C)
}if(Y[Q]===null){continue
}b=new dp.sh.Brushes[Y[Q]]();
C.style.display="none";
if(typeof (a)==="undefined"){b.noGutter=W("nogutter",E)
}else{b.noGutter=!a
}if(typeof (Z)==="undefined"){b.addControls=!W("nocontrols",E)
}else{b.addControls=Z
}if(typeof (U)==="undefined"){b.collapse=W("collapse",E)
}else{b.collapse=U
}if(typeof (B)==="undefined"){b.showColumns=W("showcolumns",E)
}else{b.showColumns=B
}var V=document.getElementsByTagName("head")[0];
if(b.Style&&V){var X=document.createElement("style");
X.setAttribute("type","text/css");
if(X.styleSheet){X.styleSheet.cssText=b.Style
}else{var O=document.createTextNode(b.Style);
X.appendChild(O)
}V.appendChild(X)
}b.firstLine=(I===null)?parseInt(P("firstline",E,1)):I;
b.Highlight(M(C[K]));
b.source=C;
C.parentNode.insertBefore(b.div,C)
}};
dp.sh.Brushes.CFamily=function(){var B="ATOM BOOL BOOLEAN BYTE CHAR COLORREF DWORD DWORDLONG DWORD_PTR DWORD32 DWORD64 FLOAT HACCEL HALF_PTR HANDLE HBITMAP HBRUSH HCOLORSPACE HCONV HCONVLIST HCURSOR HDC HDDEDATA HDESK HDROP HDWP HENHMETAFILE HFILE HFONT HGDIOBJ HGLOBAL HHOOK HICON HINSTANCE HKEY HKL HLOCAL HMENU HMETAFILE HMODULE HMONITOR HPALETTE HPEN HRESULT HRGN HRSRC HSZ HWINSTA HWND INT INT_PTR INT32 INT64 LANGID LCID LCTYPE LGRPID LONG LONGLONG LONG_PTR LONG32 LONG64 LPARAM LPBOOL LPBYTE LPCOLORREF LPCSTR LPCTSTR LPCVOID LPCWSTR LPDWORD LPHANDLE LPINT LPLONG LPSTR LPTSTR LPVOID LPWORD LPWSTR LRESULT PBOOL PBOOLEAN PBYTE PCHAR PCSTR PCTSTR PCWSTR PDWORDLONG PDWORD_PTR PDWORD32 PDWORD64 PFLOAT PHALF_PTR PHANDLE PHKEY PINT PINT_PTR PINT32 PINT64 PLCID PLONG PLONGLONG PLONG_PTR PLONG32 PLONG64 POINTER_32 POINTER_64 PSHORT PSIZE_T PSSIZE_T PSTR PTBYTE PTCHAR PTSTR PUCHAR PUHALF_PTR PUINT PUINT_PTR PUINT32 PUINT64 PULONG PULONGLONG PULONG_PTR PULONG32 PULONG64 PUSHORT PVOID PWCHAR PWORD PWSTR SC_HANDLE SC_LOCK SERVICE_STATUS_HANDLE SHORT SIZE_T SSIZE_T TBYTE TCHAR UCHAR UHALF_PTR UINT UINT_PTR UINT32 UINT64 ULONG ULONGLONG ULONG_PTR ULONG32 ULONG64 USHORT USN VOID WCHAR WORD WPARAM WPARAM WPARAM char bool short int __int32 __int64 __int8 __int16 long float double __wchar_t clock_t _complex _dev_t _diskfree_t div_t ldiv_t _exception _EXCEPTION_POINTERS FILE _finddata_t _finddatai64_t _wfinddata_t _wfinddatai64_t __finddata64_t __wfinddata64_t _FPIEEE_RECORD fpos_t _HEAPINFO _HFILE lconv intptr_t jmp_buf mbstate_t _off_t _onexit_t _PNH ptrdiff_t _purecall_handler sig_atomic_t size_t _stat __stat64 _stati64 terminate_function time_t __time64_t _timeb __timeb64 tm uintptr_t _utimbuf va_list wchar_t wctrans_t wctype_t wint_t signed";
var A="__declspec __exception __finally __try abstract as assert base bool boolean break byte case catch char checked class const const_cast continue debugger decimal default delegate delete deprecated dllexport dllimport do double dynamic_cast else enum event explicit export extends extern false final finally fixed float for foreach friend function get goto if implements implicit import in inline instanceof int interface internal is lock long mutable naked namespace native new noinline noreturn nothrow null object operator out override package params private protected public readonly ref register reinterpret_cast return sbyte sealed selectany set short sizeof stackalloc static static_cast strictfp string struct super switch synchronized template this thread throw throws transient true try typedef typeid typename typeof uint ulong unchecked union unsafe ushort using uuid var virtual void volatile whcar_t while with";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("^ *#.*","gm"),css:"preprocessor"},{regex:new RegExp(this.GetKeywords(B),"gm"),css:"datatypes"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-cpp";
this.Style=".dp-cpp .datatypes { color: #2E8B57; font-weight: bold; }"
};
dp.sh.Brushes.CFamily.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.CFamily.Aliases=["cfamily"];
dp.sh.Brushes.Cpp=function(){var B="ATOM BOOL BOOLEAN BYTE CHAR COLORREF DWORD DWORDLONG DWORD_PTR DWORD32 DWORD64 FLOAT HACCEL HALF_PTR HANDLE HBITMAP HBRUSH HCOLORSPACE HCONV HCONVLIST HCURSOR HDC HDDEDATA HDESK HDROP HDWP HENHMETAFILE HFILE HFONT HGDIOBJ HGLOBAL HHOOK HICON HINSTANCE HKEY HKL HLOCAL HMENU HMETAFILE HMODULE HMONITOR HPALETTE HPEN HRESULT HRGN HRSRC HSZ HWINSTA HWND INT INT_PTR INT32 INT64 LANGID LCID LCTYPE LGRPID LONG LONGLONG LONG_PTR LONG32 LONG64 LPARAM LPBOOL LPBYTE LPCOLORREF LPCSTR LPCTSTR LPCVOID LPCWSTR LPDWORD LPHANDLE LPINT LPLONG LPSTR LPTSTR LPVOID LPWORD LPWSTR LRESULT PBOOL PBOOLEAN PBYTE PCHAR PCSTR PCTSTR PCWSTR PDWORDLONG PDWORD_PTR PDWORD32 PDWORD64 PFLOAT PHALF_PTR PHANDLE PHKEY PINT PINT_PTR PINT32 PINT64 PLCID PLONG PLONGLONG PLONG_PTR PLONG32 PLONG64 POINTER_32 POINTER_64 PSHORT PSIZE_T PSSIZE_T PSTR PTBYTE PTCHAR PTSTR PUCHAR PUHALF_PTR PUINT PUINT_PTR PUINT32 PUINT64 PULONG PULONGLONG PULONG_PTR PULONG32 PULONG64 PUSHORT PVOID PWCHAR PWORD PWSTR SC_HANDLE SC_LOCK SERVICE_STATUS_HANDLE SHORT SIZE_T SSIZE_T TBYTE TCHAR UCHAR UHALF_PTR UINT UINT_PTR UINT32 UINT64 ULONG ULONGLONG ULONG_PTR ULONG32 ULONG64 USHORT USN VOID WCHAR WORD WPARAM WPARAM WPARAM char bool short int __int32 __int64 __int8 __int16 long float double __wchar_t clock_t _complex _dev_t _diskfree_t div_t ldiv_t _exception _EXCEPTION_POINTERS FILE _finddata_t _finddatai64_t _wfinddata_t _wfinddatai64_t __finddata64_t __wfinddata64_t _FPIEEE_RECORD fpos_t _HEAPINFO _HFILE lconv intptr_t jmp_buf mbstate_t _off_t _onexit_t _PNH ptrdiff_t _purecall_handler sig_atomic_t size_t _stat __stat64 _stati64 terminate_function time_t __time64_t _timeb __timeb64 tm uintptr_t _utimbuf va_list wchar_t wctrans_t wctype_t wint_t signed";
var A="break case catch class const __finally __exception __try const_cast continue private public protected __declspec default delete deprecated dllexport dllimport do dynamic_cast else enum explicit extern if for friend goto inline mutable naked namespace new noinline noreturn nothrow register reinterpret_cast return selectany sizeof static static_cast struct switch template this thread throw true false try typedef typeid typename union using uuid virtual void volatile whcar_t while";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("^ *#.*","gm"),css:"preprocessor"},{regex:new RegExp(this.GetKeywords(B),"gm"),css:"datatypes"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-cpp";
this.Style=".dp-cpp .datatypes { color: #2E8B57; font-weight: bold; }"
};
dp.sh.Brushes.Cpp.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Cpp.Aliases=["cpp","c","c++"];
dp.sh.Brushes.CSharp=function(){var A="abstract as base bool break byte case catch char checked class const continue decimal default delegate do double else enum event explicit extern false finally fixed float for foreach get goto if implicit in int interface internal is lock long namespace new null object operator out override params private protected public readonly ref return sbyte sealed set short sizeof stackalloc static string struct switch this throw true try typeof uint ulong unchecked unsafe ushort using virtual void while";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("^\\s*#.*","gm"),css:"preprocessor"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-c";
this.Style=".dp-c .vars { color: #d00; }"
};
dp.sh.Brushes.CSharp.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.CSharp.Aliases=["c#","c-sharp","csharp"];
dp.sh.Brushes.CSS=function(){var B="ascent azimuth background-attachment background-color background-image background-position background-repeat background baseline bbox border-collapse border-color border-spacing border-style border-top border-right border-bottom border-left border-top-color border-right-color border-bottom-color border-left-color border-top-style border-right-style border-bottom-style border-left-style border-top-width border-right-width border-bottom-width border-left-width border-width border cap-height caption-side centerline clear clip color content counter-increment counter-reset cue-after cue-before cue cursor definition-src descent direction display elevation empty-cells float font-size-adjust font-family font-size font-stretch font-style font-variant font-weight font height letter-spacing line-height list-style-image list-style-position list-style-type list-style margin-top margin-right margin-bottom margin-left margin marker-offset marks mathline max-height max-width min-height min-width orphans outline-color outline-style outline-width outline overflow padding-top padding-right padding-bottom padding-left padding page page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position quotes richness size slope src speak-header speak-numeral speak-punctuation speak speech-rate stemh stemv stress table-layout text-align text-decoration text-indent text-shadow text-transform unicode-bidi unicode-range units-per-em vertical-align visibility voice-family volume white-space widows width widths word-spacing x-height z-index";
var A="above absolute all always aqua armenian attr aural auto avoid baseline behind below bidi-override black blink block blue bold bolder both bottom braille capitalize caption center center-left center-right circle close-quote code collapse compact condensed continuous counter counters crop cross crosshair cursive dashed decimal decimal-leading-zero default digits disc dotted double embed embossed e-resize expanded extra-condensed extra-expanded fantasy far-left far-right fast faster fixed format fuchsia gray green groove handheld hebrew help hidden hide high higher icon inline-table inline inset inside invert italic justify landscape large larger left-side left leftwards level lighter lime line-through list-item local loud lower-alpha lowercase lower-greek lower-latin lower-roman lower low ltr marker maroon medium message-box middle mix move narrower navy ne-resize no-close-quote none no-open-quote no-repeat normal nowrap n-resize nw-resize oblique olive once open-quote outset outside overline pointer portrait pre print projection purple red relative repeat repeat-x repeat-y rgb ridge right right-side rightwards rtl run-in screen scroll semi-condensed semi-expanded separate se-resize show silent silver slower slow small small-caps small-caption smaller soft solid speech spell-out square s-resize static status-bar sub super sw-resize table-caption table-cell table-column table-column-group table-footer-group table-header-group table-row table-row-group teal text-bottom text-top thick thin top transparent tty tv ultra-condensed ultra-expanded underline upper-alpha uppercase upper-latin upper-roman url visible wait white wider w-resize x-fast x-high x-large x-loud x-low x-slow x-small x-soft xx-large xx-small yellow";
var C="[mM]onospace [tT]ahoma [vV]erdana [aA]rial [hH]elvetica [sS]ans-serif [sS]erif";
this.regexList=[{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("\\#[a-zA-Z0-9]{3,6}","g"),css:"value"},{regex:new RegExp("(-?\\d+)(.\\d+)?(px|em|pt|:|%|)","g"),css:"value"},{regex:new RegExp("!important","g"),css:"important"},{regex:new RegExp(this.GetKeywordsCSS(B),"gm"),css:"keyword"},{regex:new RegExp(this.GetValuesCSS(A),"g"),css:"value"},{regex:new RegExp(this.GetValuesCSS(C),"g"),css:"value"}];
this.CssClass="dp-css";
this.Style=".dp-css .value { color: black; }.dp-css .important { color: red; }"
};
dp.sh.Highlighter.prototype.GetKeywordsCSS=function(A){return"\\b([a-z_]|)"+A.replace(/ /g,"(?=:)\\b|\\b([a-z_\\*]|\\*|)")+"(?=:)\\b"
};
dp.sh.Highlighter.prototype.GetValuesCSS=function(A){return"\\b"+A.replace(/ /g,"(?!-)(?!:)\\b|\\b()")+":\\b"
};
dp.sh.Brushes.CSS.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.CSS.Aliases=["css"];
dp.sh.Brushes.Delphi=function(){var A="abs addr and ansichar ansistring array as asm begin boolean byte cardinal case char class comp const constructor currency destructor div do double downto else end except exports extended false file finalization finally for function goto if implementation in inherited int64 initialization integer interface is label library longint longword mod nil not object of on or packed pansichar pansistring pchar pcurrency pdatetime pextended pint64 pointer private procedure program property pshortstring pstring pvariant pwidechar pwidestring protected public published raise real real48 record repeat set shl shortint shortstring shr single smallint string then threadvar to true try type unit until uses val var varirnt while widechar widestring with word write writeln xor";
this.regexList=[{regex:new RegExp("\\(\\*[\\s\\S]*?\\*\\)","gm"),css:"comment"},{regex:new RegExp("{(?!\\$)[\\s\\S]*?}","gm"),css:"comment"},{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("\\{\\$[a-zA-Z]+ .+\\}","g"),css:"directive"},{regex:new RegExp("\\b[\\d\\.]+\\b","g"),css:"number"},{regex:new RegExp("\\$[a-zA-Z0-9]+\\b","g"),css:"number"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-delphi";
this.Style=".dp-delphi .number { color: blue; }.dp-delphi .directive { color: #008284; }.dp-delphi .vars { color: #000; }"
};
dp.sh.Brushes.Delphi.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Delphi.Aliases=["delphi","pascal"];
dp.sh.Brushes.Java=function(){var A="abstract assert boolean break byte case catch char class const continue default do double else enum extends false final finally float for goto if implements import instanceof int interface long native new null package private protected public return short static strictfp super switch synchronized this throw throws true transient try void volatile while";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("\\b([\\d]+(\\.[\\d]+)?|0x[a-f0-9]+)\\b","gi"),css:"number"},{regex:new RegExp("(?!\\@interface\\b)\\@[\\$\\w]+\\b","g"),css:"annotation"},{regex:new RegExp("\\@interface\\b","g"),css:"keyword"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-j";
this.Style=".dp-j .annotation { color: #646464; }.dp-j .number { color: #C00000; }"
};
dp.sh.Brushes.Java.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Java.Aliases=["java"];
dp.sh.Brushes.JScript=function(){var A="abstract boolean break byte case catch char class const continue debugger default delete do double else enum export extends false final finally float for function goto if implements import in instanceof int interface long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("^\\s*#.*","gm"),css:"preprocessor"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-c"
};
dp.sh.Brushes.JScript.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.JScript.Aliases=["js","jscript","javascript"];
dp.sh.Brushes.Php=function(){var A="abs acos acosh addcslashes addslashes array_change_key_case array_chunk array_combine array_count_values array_diff array_diff_assoc array_diff_key array_diff_uassoc array_diff_ukey array_fill array_filter array_flip array_intersect array_intersect_assoc array_intersect_key array_intersect_uassoc array_intersect_ukey array_key_exists array_keys array_map array_merge array_merge_recursive array_multisort array_pad array_pop array_product array_push array_rand array_reduce array_reverse array_search array_shift array_slice array_splice array_sum array_udiff array_udiff_assoc array_udiff_uassoc array_uintersect array_uintersect_assoc array_uintersect_uassoc array_unique array_unshift array_values array_walk array_walk_recursive atan atan2 atanh base64_decode base64_encode base_convert basename bcadd bccomp bcdiv bcmod bcmul bindec bindtextdomain bzclose bzcompress bzdecompress bzerrno bzerror bzerrstr bzflush bzopen bzread bzwrite ceil chdir checkdate checkdnsrr chgrp chmod chop chown chr chroot chunk_split class_exists closedir closelog copy cos cosh count count_chars date decbin dechex decoct deg2rad delete ebcdic2ascii echo empty end ereg ereg_replace eregi eregi_replace error_log error_reporting escapeshellarg escapeshellcmd eval exec exit exp explode extension_loaded feof fflush fgetc fgetcsv fgets fgetss file_exists file_get_contents file_put_contents fileatime filectime filegroup fileinode filemtime fileowner fileperms filesize filetype floatval flock floor flush fmod fnmatch fopen fpassthru fprintf fputcsv fputs fread fscanf fseek fsockopen fstat ftell ftok getallheaders getcwd getdate getenv gethostbyaddr gethostbyname gethostbynamel getimagesize getlastmod getmxrr getmygid getmyinode getmypid getmyuid getopt getprotobyname getprotobynumber getrandmax getrusage getservbyname getservbyport gettext gettimeofday gettype glob gmdate gmmktime ini_alter ini_get ini_get_all ini_restore ini_set interface_exists intval ip2long is_a is_array is_bool is_callable is_dir is_double is_executable is_file is_finite is_float is_infinite is_int is_integer is_link is_long is_nan is_null is_numeric is_object is_readable is_real is_resource is_scalar is_soap_fault is_string is_subclass_of is_uploaded_file is_writable is_writeable mkdir mktime nl2br parse_ini_file parse_str parse_url passthru pathinfo readlink realpath rewind rewinddir rmdir round str_ireplace str_pad str_repeat str_replace str_rot13 str_shuffle str_split str_word_count strcasecmp strchr strcmp strcoll strcspn strftime strip_tags stripcslashes stripos stripslashes stristr strlen strnatcasecmp strnatcmp strncasecmp strncmp strpbrk strpos strptime strrchr strrev strripos strrpos strspn strstr strtok strtolower strtotime strtoupper strtr strval substr substr_compare";
var B="and or xor __FILE__ __LINE__ array as break case cfunction class const continue declare default die do else elseif empty enddeclare endfor endforeach endif endswitch endwhile extends for foreach function include include_once global if new old_function return static switch use require require_once var while __FUNCTION__ __CLASS__ __METHOD__ abstract interface public implements extends private protected throw";
this.regexList=[{regex:dp.sh.RegexLib.SingleLineCComments,css:"comment"},{regex:dp.sh.RegexLib.MultiLineCComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp("\\$\\w+","g"),css:"vars"},{regex:new RegExp(this.GetKeywords(A),"gmi"),css:"func"},{regex:new RegExp(this.GetKeywords(B),"gm"),css:"keyword"}];
this.CssClass="dp-c"
};
dp.sh.Brushes.Php.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Php.Aliases=["php"];
dp.sh.Brushes.Python=function(){var B="and assert break class continue def del elif else except exec finally for from global if import in is lambda not or pass print raise return try yield while";
var A="None True False self cls class_";
this.regexList=[{regex:dp.sh.RegexLib.SingleLinePerlComments,css:"comment"},{regex:new RegExp("^\\s*@\\w+","gm"),css:"decorator"},{regex:new RegExp("(['\"]{3})([^\\1])*?\\1","gm"),css:"comment"},{regex:new RegExp("\"(?!\")(?:\\.|\\\\\\\"|[^\\\"\"\\n\\r])*\"","gm"),css:"string"},{regex:new RegExp("'(?!')*(?:\\.|(\\\\\\')|[^\\''\\n\\r])*'","gm"),css:"string"},{regex:new RegExp("\\b\\d+\\.?\\w*","g"),css:"number"},{regex:new RegExp(this.GetKeywords(B),"gm"),css:"keyword"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"special"}];
this.CssClass="dp-py";
this.Style=".dp-py .builtins { color: #ff1493; }.dp-py .magicmethods { color: #808080; }.dp-py .exceptions { color: brown; }.dp-py .types { color: brown; font-style: italic; }.dp-py .commonlibs { color: #8A2BE2; font-style: italic; }"
};
dp.sh.Brushes.Python.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Python.Aliases=["py","python"];
dp.sh.Brushes.Ruby=function(){var A="alias and BEGIN begin break case class def define_method defined do each else elsif END end ensure false for if in module new next nil not or raise redo rescue retry return self super then throw true undef unless until when while yield";
var B="Array Bignum Binding Class Continuation Dir Exception FalseClass File::Stat File Fixnum Fload Hash Integer IO MatchData Method Module NilClass Numeric Object Proc Range Regexp String Struct::TMS Symbol ThreadGroup Thread Time TrueClass";
this.regexList=[{regex:dp.sh.RegexLib.SingleLinePerlComments,css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp(":[a-z][A-Za-z0-9_]*","g"),css:"symbol"},{regex:new RegExp("(\\$|@@|@)\\w+","g"),css:"variable"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"},{regex:new RegExp(this.GetKeywords(B),"gm"),css:"builtin"}];
this.CssClass="dp-rb";
this.Style=".dp-rb .symbol { color: #a70; }.dp-rb .variable { color: #a70; font-weight: bold; }"
};
dp.sh.Brushes.Ruby.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Ruby.Aliases=["ruby","rails","ror"];
dp.sh.Brushes.Sql=function(){var B="abs avg case cast coalesce convert count current_timestamp current_user day isnull left lower month nullif replace right session_user space substring sum system_user upper user year";
var C="absolute action add after alter as asc at authorization begin bigint binary bit by cascade char character check checkpoint close collate column commit committed connect connection constraint contains continue create cube current current_date current_time cursor database date deallocate dec decimal declare default delete desc distinct double drop dynamic else end end-exec escape except exec execute false fetch first float for force foreign forward free from full function global goto grant group grouping having hour ignore index inner insensitive insert instead int integer intersect into is isolation key last level load local max min minute modify move name national nchar next no numeric of off on only open option order out output partial password precision prepare primary prior privileges procedure public read real references relative repeatable restrict return returns revoke rollback rollup rows rule schema scroll second section select sequence serializable set size smallint static statistics table temp temporary then time timestamp to top transaction translation trigger true truncate uncommitted union unique update values varchar varying view when where with work";
var A="all and any between cross in join like not null or outer some";
this.regexList=[{regex:new RegExp("--(.*)$","gm"),css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:dp.sh.RegexLib.SingleQuotedString,css:"string"},{regex:new RegExp(this.GetKeywords(B),"gmi"),css:"func"},{regex:new RegExp(this.GetKeywords(A),"gmi"),css:"op"},{regex:new RegExp(this.GetKeywords(C),"gmi"),css:"keyword"}];
this.CssClass="dp-sql";
this.Style=".dp-sql .func { color: #ff1493; }.dp-sql .op { color: #808080; }"
};
dp.sh.Brushes.Sql.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Sql.Aliases=["sql"];
dp.sh.Brushes.Vb=function(){var A="AddHandler AddressOf AndAlso Alias And Ansi As Assembly Auto Boolean ByRef Byte ByVal Call Case Catch CBool CByte CChar CDate CDec CDbl Char CInt Class CLng CObj Const CShort CSng CStr CType Date Decimal Declare Default Delegate Dim DirectCast Do Double Each Else ElseIf End Enum Erase Error Event Exit False Finally For Friend Function Get GetType GoSub GoTo Handles If Implements Imports In Inherits Integer Interface Is Let Lib Like Long Loop Me Mod Module MustInherit MustOverride MyBase MyClass Namespace New Next Not Nothing NotInheritable NotOverridable Object On Option Optional Or OrElse Overloads Overridable Overrides ParamArray Preserve Private Property Protected Public RaiseEvent ReadOnly ReDim REM RemoveHandler Resume Return Select Set Shadows Shared Short Single Static Step Stop String Structure Sub SyncLock Then Throw To True Try TypeOf Unicode Until Variant When While With WithEvents WriteOnly Xor";
this.regexList=[{regex:new RegExp("'.*$","gm"),css:"comment"},{regex:dp.sh.RegexLib.DoubleQuotedString,css:"string"},{regex:new RegExp("^\\s*#.*","gm"),css:"preprocessor"},{regex:new RegExp(this.GetKeywords(A),"gm"),css:"keyword"}];
this.CssClass="dp-vb"
};
dp.sh.Brushes.Vb.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Vb.Aliases=["vb","vb.net"];
dp.sh.Brushes.Xml=function(){this.CssClass="dp-xml";
this.Style=".dp-xml .cdata { color: #ff1493; }.dp-xml .tag, .dp-xml .tag-name { color: #069; font-weight: bold; }.dp-xml .attribute { color: red; }.dp-xml .attribute-value { color: blue; }"
};
dp.sh.Brushes.Xml.prototype=new dp.sh.Highlighter();
dp.sh.Brushes.Xml.Aliases=["xml","xhtml","xslt","html","xhtml"];
dp.sh.Brushes.Xml.prototype.ProcessRegexList=function(){function C(F,E){F[F.length]=E
}var B=0;
var A=null;
var D=null;
this.GetMatches(new RegExp("(&lt;|<)\\!\\[[\\w\\s]*?\\[(.|\\s)*?\\]\\](&gt;|>)","gm"),"cdata");
this.GetMatches(new RegExp("(&lt;|<)!--\\s*.*?\\s*--(&gt;|>)","gm"),"comments");
D=new RegExp("([:\\w-.]+)\\s*=\\s*(\".*?\"|'.*?'|\\w+)*|(\\w+)","gm");
while((A=D.exec(this.code))!=null){if(A[1]==null){continue
}C(this.matches,new dp.sh.Match(A[1],A.index,"attribute"));
if(A[2]!=undefined){C(this.matches,new dp.sh.Match(A[2],A.index+A[0].indexOf(A[2]),"attribute-value"))
}}this.GetMatches(new RegExp("(&lt;|<)/*\\?*(?!\\!)|/*\\?*(&gt;|>)","gm"),"tag");
D=new RegExp("(?:&lt;|<)/*\\?*\\s*([:\\w-.]+)","gm");
while((A=D.exec(this.code))!=null){C(this.matches,new dp.sh.Match(A[1],A.index+A[0].indexOf(A[1]),"tag-name"))
}}
