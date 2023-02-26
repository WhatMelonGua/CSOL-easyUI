(()=>{var e={660:(e,t,n)=>{var i=n(81),r=n(645),o=n(667),s=n(47),l=r(i),a=o(s);l.push([e.id,"body{\r\n    margin: 0;\r\n    padding: 0;\r\n    position: absolute;\r\n}\r\ninput{\r\n    width: 80px;\r\n}\r\nbutton{\r\n    width: 30%;\r\n    color: rgb(100,80,130);\r\n    margin: 0 10% 10px 10%;\r\n    font-size: 14px;\r\n    border: 2px solid rgb(120,120,120);\r\n}\r\nbutton:hover{\r\n    color: rgb(255,255,255);\r\n    background-color: rgb(100,80,80);\r\n}\r\nbutton:active{\r\n    color: rgb(120,80,200);\r\n    background-color: rgb(0,0,0);\r\n}\r\n\r\n.title{\r\n    text-align: center;\r\n    font-weight: bolder;\r\n    color: rgb(50,50,50);\r\n    font-size: 24px;\r\n    margin-top: 10px;\r\n}\r\n\r\n.studio{\r\n    display: flex;\r\n    flex-direction: row;\r\n    width: 100%;\r\n    height: 100%;\r\n    background-image: url("+a+");\r\n    background-size: cover;\r\n}\r\n.paintDiv{\r\n    display: flex;\r\n    align-items: center;\r\n    justify-content: center;\r\n    width: 76%;\r\n}\r\n.uiCanvas{\r\n    position: absolute;\r\n    width: 600px;\r\n    height: 600px;\r\n    background-color: rgb(255,255,255);\r\n    border: 1px double rgb(100,100,160);\r\n    box-shadow: 0 0 5px 5px rgba(0,0,0,0.2);\r\n    overflow: hidden;\r\n    transform: scale(1);\r\n    background-size: 100% 100%;\r\n}\r\n\r\n.toolDiv{\r\n    user-select: none;\r\n    display: flex;\r\n    color: rgb(100,100,100);\r\n    font-weight: bold;\r\n    padding-left: 40px;\r\n    padding-right: 40px;\r\n    width: 24%;\r\n    height: 100%;\r\n    flex-direction: column;\r\n    justify-content: flex-start;\r\n    align-items: center;\r\n    background-color: rgb(250,250,250);\r\n    border-left: 1px solid rgb(100,100,160);\r\n}\r\n.bar{\r\n    display: flex;\r\n    flex-wrap: wrap;\r\n    justify-content: space-around;\r\n    align-items: center;\r\n    width: 100%;\r\n    margin-top: 16px;\r\n}\r\n.gap{\r\n    width: 100%;\r\n    height: 2px;\r\n    margin-top: 10px;\r\n    background-color: rgb(200,200,200);\r\n}\r\n\r\n.space{\r\n    width: 40px;\r\n}\r\n\r\n.objList{\r\n    font-size: 16px;\r\n    width: 100%;\r\n    height: 120px;\r\n    border-radius: 5px;\r\n    border: 1px solid rgb(100,100,100);\r\n    background-color: rgb(255,255,255);\r\n    overflow: scroll;\r\n    padding: 0 10px 0 10px;\r\n}\r\n.tag{\r\n    cursor: pointer;\r\n    user-select: none;\r\n    width: 100%;\r\n    margin: 6px 0 0 0;\r\n    text-align: left;\r\n    background-color: rgb(255,255,255);\r\n}\r\n.sonTag{\r\n    margin-left: 20px;\r\n}\r\n.hide{\r\n    display: none;\r\n}\r\n\r\n.resizeTool {\r\n    display: none;\r\n    position: absolute;\r\n    border: 1px solid black;\r\n    background-color: white;\r\n    box-sizing: border-box;\r\n    width: 6px;\r\n    height: 6px;\r\n    z-index: 999;\r\n}\r\n.nwse{\r\n    cursor: nwse-resize;\r\n}\r\n.nesw{\r\n    cursor: nesw-resize;\r\n}\r\n\r\n.moveTool{\r\n    display: none;\r\n    position: absolute;\r\n    border-radius: 10px;\r\n    width: 10px; height: 10px;\r\n    border: 3px double black;\r\n    box-sizing: border-box;\r\n    background-color: white;\r\n    cursor: move;\r\n    z-index: 999;\r\n}\r\n.groupArea{\r\n    display: none;\r\n    position: absolute;\r\n    border: 1px dashed black;\r\n    box-sizing: border-box;\r\n}\r\n\r\n.fileSet{\r\n    display: flex;\r\n    justify-content: space-around;\r\n    flex-wrap: wrap;\r\n    width: 280px;\r\n    float: left;\r\n    position: absolute;\r\n    margin: 20px;\r\n}\r\n\r\n.renameBar{\r\n    font-size: 20px;\r\n    font-weight: bold;\r\n    border-radius: 6px;\r\n    align-items: center;\r\n    justify-content: space-around;\r\n    flex-wrap: wrap;\r\n    top: -10px;\r\n    padding: 20px;\r\n    position: absolute;\r\n    display: flex;\r\n    float: bottom;\r\n    width: 24%;\r\n    height: 40px;\r\n    background-color: whitesmoke;\r\n    filter: drop-shadow(0 0 5px rgb(100,100,100));\r\n}\r\n.renameBar input{\r\n    width: 100px;\r\n    height: 24px;\r\n}\r\n\r\n.mask{\r\n    display: none;\r\n    top: 0;\r\n    position: absolute;\r\n    float: left;\r\n    width: 100%;\r\n    height: 100%;\r\n    align-items: center;\r\n    justify-content: space-around;\r\n    background-color: rgba(0,0,0,0.2);\r\n}\r\n.help{\r\n    width: 60%;\r\n    border-radius: 10px;\r\n    box-shadow: 0 0 15px rgba(0,0,0,0.3);\r\n    align-items: center;\r\n    justify-content: center;\r\n    background-color: floralwhite;\r\n}\r\n.cont{\r\n    font-weight: bold;\r\n    color: rgb(100,100,100);\r\n    margin-bottom: 10px;\r\n}\r\n.selectArea{\r\n    display: none;\r\n    position: absolute;\r\n    border: 1px dashed black;\r\n    box-sizing: border-box;\r\n}",""]),e.exports=l},645:e=>{"use strict";e.exports=function(e){var t=[];return t.toString=function(){return this.map((function(t){var n="",i=void 0!==t[5];return t[4]&&(n+="@supports (".concat(t[4],") {")),t[2]&&(n+="@media ".concat(t[2]," {")),i&&(n+="@layer".concat(t[5].length>0?" ".concat(t[5]):""," {")),n+=e(t),i&&(n+="}"),t[2]&&(n+="}"),t[4]&&(n+="}"),n})).join("")},t.i=function(e,n,i,r,o){"string"==typeof e&&(e=[[null,e,void 0]]);var s={};if(i)for(var l=0;l<this.length;l++){var a=this[l][0];null!=a&&(s[a]=!0)}for(var d=0;d<e.length;d++){var h=[].concat(e[d]);i&&s[h[0]]||(void 0!==o&&(void 0===h[5]||(h[1]="@layer".concat(h[5].length>0?" ".concat(h[5]):""," {").concat(h[1],"}")),h[5]=o),n&&(h[2]?(h[1]="@media ".concat(h[2]," {").concat(h[1],"}"),h[2]=n):h[2]=n),r&&(h[4]?(h[1]="@supports (".concat(h[4],") {").concat(h[1],"}"),h[4]=r):h[4]="".concat(r)),t.push(h))}},t}},667:e=>{"use strict";e.exports=function(e,t){return t||(t={}),e?(e=String(e.__esModule?e.default:e),/^['"].*['"]$/.test(e)&&(e=e.slice(1,-1)),t.hash&&(e+=t.hash),/["'() \t\n]|(%20)/.test(e)||t.needQuotes?'"'.concat(e.replace(/"/g,'\\"').replace(/\n/g,"\\n"),'"'):e):e}},81:e=>{"use strict";e.exports=function(e){return e[1]}},47:(e,t,n)=>{e.exports=n.p+"static/img/452eee8dcac76ce0daacfd3580b9f5b8.png"},379:e=>{"use strict";var t=[];function n(e){for(var n=-1,i=0;i<t.length;i++)if(t[i].identifier===e){n=i;break}return n}function i(e,i){for(var o={},s=[],l=0;l<e.length;l++){var a=e[l],d=i.base?a[0]+i.base:a[0],h=o[d]||0,u="".concat(d," ").concat(h);o[d]=h+1;var c=n(u),g={css:a[1],media:a[2],sourceMap:a[3],supports:a[4],layer:a[5]};if(-1!==c)t[c].references++,t[c].updater(g);else{var p=r(g,i);i.byIndex=l,t.splice(l,0,{identifier:u,updater:p,references:1})}s.push(u)}return s}function r(e,t){var n=t.domAPI(t);return n.update(e),function(t){if(t){if(t.css===e.css&&t.media===e.media&&t.sourceMap===e.sourceMap&&t.supports===e.supports&&t.layer===e.layer)return;n.update(e=t)}else n.remove()}}e.exports=function(e,r){var o=i(e=e||[],r=r||{});return function(e){e=e||[];for(var s=0;s<o.length;s++){var l=n(o[s]);t[l].references--}for(var a=i(e,r),d=0;d<o.length;d++){var h=n(o[d]);0===t[h].references&&(t[h].updater(),t.splice(h,1))}o=a}}},569:e=>{"use strict";var t={};e.exports=function(e,n){var i=function(e){if(void 0===t[e]){var n=document.querySelector(e);if(window.HTMLIFrameElement&&n instanceof window.HTMLIFrameElement)try{n=n.contentDocument.head}catch(e){n=null}t[e]=n}return t[e]}(e);if(!i)throw new Error("Couldn't find a style target. This probably means that the value for the 'insert' parameter is invalid.");i.appendChild(n)}},216:e=>{"use strict";e.exports=function(e){var t=document.createElement("style");return e.setAttributes(t,e.attributes),e.insert(t,e.options),t}},565:(e,t,n)=>{"use strict";e.exports=function(e){var t=n.nc;t&&e.setAttribute("nonce",t)}},795:e=>{"use strict";e.exports=function(e){var t=e.insertStyleElement(e);return{update:function(n){!function(e,t,n){var i="";n.supports&&(i+="@supports (".concat(n.supports,") {")),n.media&&(i+="@media ".concat(n.media," {"));var r=void 0!==n.layer;r&&(i+="@layer".concat(n.layer.length>0?" ".concat(n.layer):""," {")),i+=n.css,r&&(i+="}"),n.media&&(i+="}"),n.supports&&(i+="}");var o=n.sourceMap;o&&"undefined"!=typeof btoa&&(i+="\n/*# sourceMappingURL=data:application/json;base64,".concat(btoa(unescape(encodeURIComponent(JSON.stringify(o))))," */")),t.styleTagTransform(i,e,t.options)}(t,e,n)},remove:function(){!function(e){if(null===e.parentNode)return!1;e.parentNode.removeChild(e)}(t)}}}},589:e=>{"use strict";e.exports=function(e,t){if(t.styleSheet)t.styleSheet.cssText=e;else{for(;t.firstChild;)t.removeChild(t.firstChild);t.appendChild(document.createTextNode(e))}}}},t={};function n(i){var r=t[i];if(void 0!==r)return r.exports;var o=t[i]={id:i,exports:{}};return e[i](o,o.exports,n),o.exports}n.n=e=>{var t=e&&e.__esModule?()=>e.default:()=>e;return n.d(t,{a:t}),t},n.d=(e,t)=>{for(var i in t)n.o(t,i)&&!n.o(e,i)&&Object.defineProperty(e,i,{enumerable:!0,get:t[i]})},n.g=function(){if("object"==typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"==typeof window)return window}}(),n.o=(e,t)=>Object.prototype.hasOwnProperty.call(e,t),(()=>{var e;n.g.importScripts&&(e=n.g.location+"");var t=n.g.document;if(!e&&t&&(t.currentScript&&(e=t.currentScript.src),!e)){var i=t.getElementsByTagName("script");i.length&&(e=i[i.length-1].src)}if(!e)throw new Error("Automatic publicPath is not supported in this browser");e=e.replace(/#.*$/,"").replace(/\?.*$/,"").replace(/\/[^\/]+$/,"/"),n.p=e})(),n.nc=void 0,(()=>{"use strict";var e=n(379),t=n.n(e),i=n(795),r=n.n(i),o=n(569),s=n.n(o),l=n(565),a=n.n(l),d=n(216),h=n.n(d),u=n(589),c=n.n(u),g=n(660),p=n.n(g),f={};function m(e){return 0===e.indexOf("#")?function(e){let t="000000"+(16777215-(e="0x"+e.replace(/#/g,""))).toString(16);return"#"+t.substring(t.length-6,t.length)}(e):0===e.indexOf("rgb(")?function(e){let t=e.replace(/rgb\(/g,"").replace(/\)/g,"").split(",");return"rgb("+(255-parseInt(t[0]))+","+(255-parseInt(t[1]))+","+(255-parseInt(t[2]))+")"}(e):void 0}function x(){return document.documentElement.scrollLeft||document.body.scrollLeft}function y(){return document.documentElement.scrollTop||document.body.scrollTop}f.styleTagTransform=c(),f.setAttributes=a(),f.insert=s().bind(null,"head"),f.domAPI=r(),f.insertStyleElement=h(),t()(p(),f),p()&&p().locals&&p().locals;let b=/^((\+|-) Group\[\d+])/,v=/^(■ UI.Box\[\d+])/;class w{constructor(e,t,n,i){this.name="",this.typeG=!1,this.dom=t,this.tag=n,this.group=null,this.key=i,this.x=Math.fround(e.x),this.y=Math.fround(e.y),this.width=Math.fround(e.width),this.height=Math.fround(e.height),this.r=Math.round(e.r),this.g=Math.round(e.g),this.b=Math.round(e.b),this.a=Math.round(e.a)}getColor(){return{r:this.r,g:this.g,b:this.b,a:this.a}}getPosition(){return{x:this.x,y:this.y}}getSize(){return{width:this.width,height:this.height}}getSet(){return{x:this.x,y:this.y,width:this.width,height:this.height,r:this.r,g:this.g,b:this.b,a:this.a}}setColor(e,t,n,i){this.r=Math.fround(e),this.g=Math.fround(t),this.b=Math.fround(n),this.a=Math.fround(i),this.dom.style.backgroundColor=this._getRGBAstr()}setPosition(e,t){this.x=Math.fround(e),this.y=Math.fround(t),this.dom.style.left=this.x+"px",this.dom.style.top=this.y+"px"}_move(e,t){this.x=Math.fround(this.x+e),this.y=Math.fround(this.y+t),this.dom.style.left=this.x+"px",this.dom.style.top=this.y+"px"}setSize(e,t){this.width=Math.fround(e),this.height=Math.fround(t),this.dom.style.width=this.width+"px",this.dom.style.height=this.height+"px"}updateSet(e,t){this.x=Math.fround(e.x),this.y=Math.fround(e.y),this.width=Math.fround(e.width),this.height=Math.fround(e.height),this.r=Math.round(e.r),this.g=Math.round(e.g),this.b=Math.round(e.b),this.a=Math.round(e.a);let n="position:absolute;left:"+this.x+"px;top:"+this.y+"px;width:"+this.width+"px;height:"+this.height+"px;background-color:"+this._getRGBAstr()+";opacity:"+this.a/255+";box-sizing:border-box;";t&&(n+="border:1.5px dashed "+m(this.dom.style.backgroundColor)+";"),this.dom.style=n}setGroup(e){this.group=e}domDestroy(){this.dom.remove(),this.tag.remove()}domSelected(){this.dom.style.border="1.5px dashed "+m(this.dom.style.backgroundColor),this.tag.style.color="rgb(50,100,250)",this.tag.style.textDecoration="underline"}domUnSelected(){this.dom.style.border="",this.tag.style.color="inherit",this.tag.style.textDecoration="none"}_getRGBAstr(){return"rgba("+this.r+","+this.g+","+this.b+","+this.a+")"}setName(e){this.name=e.replace(/\s+/g,""),this.tag.innerHTML=v[Symbol.match](this.tag.innerHTML)[0]+this.name}getSetInt(){return{x:Math.round(this.x),y:Math.round(this.y),width:Math.round(this.width),height:Math.round(this.height),r:Math.round(this.r),g:Math.round(this.g),b:Math.round(this.b),a:Math.round(this.a)}}}class k{constructor(e,t,n){this.name="",this.uiBoxList=e,this.tag=t,this.key=n,this.typeG=!0,this.x=this.uiBoxList[0].x,this.y=this.uiBoxList[0].y,this.width=this.uiBoxList[0].width,this.height=this.uiBoxList[0].height,this.init()}init(){this.uiBoxList.length>0&&(this.x=this.uiBoxList[0].x,this.y=this.uiBoxList[0].y,this.width=this.uiBoxList[0].width,this.height=this.uiBoxList[0].height),this.initPos(),this.initSize()}initPos(){for(let e of this.uiBoxList)e.x<this.x&&(this.x=e.x),e.y<this.y&&(this.y=e.y)}initSize(){for(let e of this.uiBoxList){let t=e.x+e.width-this.x,n=e.y+e.height-this.y;t>this.width&&(this.width=t),n>this.height&&(this.height=n)}}getSon(){return this.uiBoxList}getSonKey(){let e=[];for(let t of this.uiBoxList)e.push(t.key);return e}getSonCount(){return this.uiBoxList.length}getPosition(){return{x:this.x,y:this.y}}getSize(){return{width:this.width,height:this.height}}getSet(){return{x:this.x,y:this.y,width:this.width,height:this.height}}setColor(e,t,n,i){return null}setPosition(e,t){let n={x:e-this.x,y:t-this.y};this.x=Math.fround(e),this.y=Math.fround(t);for(let e of this.uiBoxList)e._move(n.x,n.y)}_move(e,t){this.setPosition(this.x+e,this.y+t)}setSize(e,t){let n=e/this.width,i=t/this.height;console.log(e),this.width=Math.fround(e),this.height=Math.fround(t);for(let e of this.uiBoxList){let t=this.x+(e.x-this.x)*n,r=this.y+(e.y-this.y)*i;e.setPosition(t,r),t=e.width*n,r=e.height*i,e.setSize(t,r)}}updateSet(e,t){this.setPosition(Math.fround(e.x),Math.fround(e.y)),this.setSize(Math.fround(e.width),Math.fround(e.height))}domDestroy(){let e=[];for(let t of this.uiBoxList)e.push(t.key),t.domDestroy();return this.tag.remove(),e}domSelected(){for(let e of this.uiBoxList)e.domSelected();this.tag.style.color="rgb(50,100,250)",this.tag.style.textDecoration="underline"}domUnSelected(){this.tag.style.color="inherit",this.tag.style.textDecoration="none";for(let e of this.uiBoxList)e.domUnSelected()}deleteBox(e){let t=this.uiBoxList.indexOf(e);console.log(this.uiBoxList),this.uiBoxList.splice(t,1),this.init()}setName(e){this.name=e.replace(/\s+/g,"");let t=this.tag.firstChild.innerHTML;this.tag.firstChild.innerHTML=b[Symbol.match](t)[0]+this.name}}function B(e,t,n,i,r,o,s,l){return{x:e,y:t,width:n,height:i,r,g:o,b:s,a:l}}function L(e){let t={r:0,g:0,b:"0"};return t.r=parseInt("0x"+e.slice(1,3)),t.g=parseInt("0x"+e.slice(3,5)),t.b=parseInt("0x"+e.slice(5,7)),t}function E(e){e=[e.r.toString(16),e.g.toString(16),e.b.toString(16)];let t="#";for(let n of e)n.length<2?t+="0"+n:t+=n;return t}function S(e,t,n,i,r){let o="";null==r&&(r=[0,0]),""==e.name?o+="uiBox_"+e.key+"=":o+=e.name+"=",i||(o="");let s=e.getSetInt();return o+t+"{x="+(s.x-r[0])+",y="+(s.y-r[1])+",width="+s.width+",height="+s.height+",r="+s.r+",g="+s.g+",b="+s.b+",a="+s.a+"}"+n}function M(e,t){let n=e.getSetInt();return n.x-t[0]+","+(n.y-t[1])+","+n.width+","+n.height+","}document.ondragstart=()=>!1;let C=document.getElementsByClassName("uiCanvas")[0],I=document.getElementsByClassName("objList")[0],z=document.getElementById("boxCount");document.title="uiBox Painter  600x600";let T={num:1},O={num:-1},j=document.getElementsByClassName("resizeTool"),P=document.getElementsByClassName("moveTool")[0],N=document.getElementsByClassName("groupArea")[0],U=document.getElementsByClassName("selectArea")[0],A={flag:!1,x1:null,y1:null,x2:null,y2:null},G=new class{constructor(e,t,n){this.uiBox=null,this.start=null,this.end=null,this.resize=e,this.move=t,this.group=n}setBox(e){this.uiBox=e,this.start=[e.x,e.y],this.end=[e.x+e.width,e.y+e.height],this.show()}show(){this.group.style.display="none";let e=3;this.resize[0].style.left=this.start[0]-e+"px",this.resize[0].style.top=this.start[1]-e+"px",this.resize[0].style.display="block",this.resize[1].style.left=this.end[0]-e+"px",this.resize[1].style.top=this.start[1]-e+"px",this.resize[1].style.display="block",this.resize[2].style.left=this.end[0]-e+"px",this.resize[2].style.top=this.end[1]-e+"px",this.resize[2].style.display="block",this.resize[3].style.left=this.start[0]-e+"px",this.resize[3].style.top=this.end[1]-e+"px",this.resize[3].style.display="block",e=5,this.move.style.left=this.start[0]-e+(this.end[0]-this.start[0])/2+"px",this.move.style.top=this.start[1]-e+(this.end[1]-this.start[1])/2+"px",this.move.style.display="block",this.uiBox.typeG&&(this.group.style.left=this.uiBox.x+"px",this.group.style.top=this.uiBox.y+"px",this.group.style.width=this.uiBox.width+"px",this.group.style.height=this.uiBox.height+"px",this.group.style.display="block")}hide(){this.uiBox.domUnSelected(),this.uiBox=null;for(let e of this.resize)e.style.display="none";this.move.style.display="none",this.group.style.display="none"}}(j,P,N),_={},D=!0,H={move:!1,ulSize:!1,urSize:!1,dlSize:!1,drSize:!1};function R(){for(let e in H)H[e]=!1}function F(e){let t=function(e,t){let n=x(),i=y();return[e.offsetLeft-e.clientWidth*(t-1)/2+n,e.offsetTop-e.clientHeight*(t-1)/2+i]}(C,Q);return t[0]=(e.pageX+x()-t[0])/Q,t[1]=(e.pageY+y()-t[1])/Q,t}function $(e){if(e.stopPropagation(),Object.keys(_).length>0)switch(e.srcElement.getAttribute("id")){case"move":H.move=!0;break;case"ul":H.ulSize=!0;break;case"ur":H.urSize=!0;break;case"dr":H.drSize=!0;break;case"dl":H.dlSize=!0}}function J(e){e.stopPropagation(),R()}C.addEventListener("mousemove",(function(e){e.stopPropagation();let t=F(e);if(Object.keys(_).length>0){let e=G.uiBox;if(H.move){let n=t[0]-e.width/2,i=t[1]-e.height/2,r=[n-e.x,i-e.y];for(let e in _){let t=null;t=e>0?T[e]:O[e],t.setPosition(t.x+r[0],t.y+r[1])}G.setBox(e),Y(e.getSet())}else if(H.ulSize){let n=e.x+e.width,i=e.y+e.height;t[0]<n&&t[1]<i&&(e.setPosition(t[0],t[1]),e.setSize(n-t[0],i-t[1])),G.setBox(e),Y(e.getSet())}else if(H.urSize){let n=e.x,i=e.y+e.height;t[0]>n&&t[1]<i&&(e.setPosition(n,t[1]),e.setSize(t[0]-n,i-t[1])),G.setBox(e),Y(e.getSet())}else if(H.drSize){let n=t[0]-e.x,i=t[1]-e.y;t[0]>e.x&&t[1]>e.y&&e.setSize(n,i),G.setBox(e),Y(e.getSet())}else if(H.dlSize){let n=e.x+e.width,i=e.y;t[0]<n&&t[1]>i&&(e.setPosition(t[0],i),e.setSize(n-t[0],t[1]-i)),G.setBox(e),Y(e.getSet())}}else!D&&A.flag&&(U.style.width=t[0]-A.x1+"px",U.style.height=t[1]-A.y1+"px",A.x2=t[0],A.y2=t[1])})),C.addEventListener("mousedown",(function(e){if(!D){let t=F(e);U.style.top=t[1]+"px",U.style.left=t[0]+"px",U.style.display="block",A.x1=t[0],A.y1=t[1],A.flag=!0}})),C.addEventListener("mouseup",(function(e){if(!D&&A.flag){for(let e in T){if("num"==e)continue;let t=T[e];t.x>A.x1&&t.x+t.width<A.x2&&t.y>A.y1&&t.y+t.height<A.y2&&null==t.group&&Z(e)}for(let e in O){if("num"==e)continue;let t=O[e];t.x>A.x1&&t.x+t.width<A.x2&&t.y>A.y1&&t.y+t.height<A.y2&&te(e)}}U.style.display="none",U.style.width="0px",U.style.height="0px"})),P.addEventListener("mousedown",$),P.addEventListener("mouseup",J);for(let e of j)e.addEventListener("mousedown",$),e.addEventListener("mouseup",J);let W={x:document.getElementById("x"),y:document.getElementById("y"),width:document.getElementById("width"),height:document.getElementById("height"),color:document.getElementById("colorSet"),a:document.getElementById("a")},K={set:document.getElementById("boxSet"),group:document.getElementById("boxGroup"),new:document.getElementById("boxNew"),delete:document.getElementById("boxDelete"),clone:document.getElementById("boxClone"),ungroup:document.getElementById("boxUnGroup")},q={colorSet:document.getElementById("canvasColor"),r:document.getElementById("bgR"),g:document.getElementById("bgG"),b:document.getElementById("bgB"),resize:document.getElementById("canvasSize"),width:document.getElementById("bgWidth"),height:document.getElementById("bgHeight"),scale:document.getElementById("bgScale"),scaleSet:document.getElementById("canvasScale")},Q=1,X={clear:document.getElementById("clearCanvas"),export:document.getElementById("export"),exportComp:document.getElementById("exportComp"),exportFont:document.getElementById("exportFont")};function Y(e){W.x.value=Math.round(e.x),W.y.value=Math.round(e.y),W.width.value=Math.round(e.width),W.height.value=Math.round(e.height),W.a.value=e.a||255,e.r&&(W.color.value=E({r:e.r,g:e.g,b:e.b}))}function V(e){e>0?T[e].domUnSelected():O[e].domUnSelected()}function Z(e,t){let n=T[e];if(n.group in _&&ne(T[e].group),e in _&&(_[e].domUnSelected(),delete _[e]),D){for(let e in _)V(e);_={}}null!=n.group&&t?te(n.group,!0):(_[e]=n,n.domSelected(),G.setBox(n),t&&(I.scrollTop=n.tag.offsetTop-I.clientHeight),Y(n.getSet()))}function ee(e){delete _[e],T[e].domUnSelected(),G.hide(),R()}function te(e,t){let n=O[e];if(e in _&&(_[e].domUnSelected(),delete _[e]),D){for(let e in _)V(e);_={}}else for(let e of n.uiBoxList)e.key in _&&ee(e.key);Y(n.getSet()),t&&(I.scrollTop=n.tag.offsetTop-I.clientHeight),_[e]=n,n.init(),n.domSelected(),G.setBox(n)}function ne(e){delete _[e],O[e].domUnSelected(),G.hide(),R()}function ie(e){let t=!0,n=e.srcElement.getAttribute("key"),i=null;e.srcElement.classList.length>0&&(t=!1),n>0?(i=T[n],Z(n,t)):(i=O[n],te(n,t)),e.stopPropagation()}function re(e){e.preventDefault();let t=e.srcElement,n=t.innerText.substr(1),i=e.srcElement.parentElement.children;if("+"==t.innerText.slice(0,1)){t.innerText="-"+n;for(let e of i)e.classList.contains("sonTag")&&e.classList.remove("hide")}else{t.innerText="+"+n;for(let e of i)e.classList.contains("sonTag")&&e.classList.add("hide")}}function oe(e,t){return e>t?1:e<t?-1:0}function se(){let e=[];for(let t in T){if("num"==t)continue;let n=T[t];null==n.group&&e.push(parseInt(n.key))}if(e.length>0){e=e.sort(oe);let t=e[0].tag;for(let n of e){if(0==n)continue;let e=T[n.toString()];I.insertBefore(e.tag,t)}}}function le(e,t){let n=O.num,i=[],r=document.createElement("div"),o=document.createElement("div");o.addEventListener("contextmenu",re),r.classList.add("tag"),o.innerHTML="+ Group["+Math.abs(n)+"]",o.setAttribute("key",n),o.addEventListener("click",ie),r.appendChild(o);for(let t of e){let e=T[t];i.push(e),e.setGroup(n),e.tag.classList.add("hide"),e.tag.classList.add("sonTag"),r.appendChild(e.tag)}return I.appendChild(r),O[n]=new k(i,r,n),O.num-=1,t&&O[n].setName(t),te(n,!0),n}function ae(){if(Object.keys(_).length>0){for(let e in _)de(e);_={},G.hide()}z.innerHTML=parseInt(Object.keys(T).length)-1}function de(e){if(e>0){let t=T[e];t.group&&O[t.group].deleteBox(t),t.domDestroy(),delete T[e]}else{let t=O[e].domDestroy();for(let e of t)delete T[e];delete O[e]}}function he(e){if(Object.keys(_).length>0)for(let t in _){let n=null;n=t>0?T[t]:O[t],n._move(0,e),G.setBox(n),Y(n.getSet())}}function ue(e){if(Object.keys(_).length>0)for(let t in _){let n=null;n=t>0?T[t]:O[t],n._move(e,0),G.setBox(n),Y(n.getSet())}}function ce(){let e=G.uiBox,t=L(W.color.value),n=B(W.x.value,W.y.value,W.width.value,W.height.value,t.r,t.g,t.b,W.a.value);e.updateSet(n,!0),G.setBox(e)}function ge(){let e=[];if(Object.keys(_).length>0){for(let t in _)if(t>0)e.push(Se(T[t].getSet())),T[t].domUnSelected();else{let n=O[t],i=[];for(let e of n.uiBoxList)i.push(Se(e.getSet()));n.domUnSelected(),e.push(le(i))}_={};for(let t of e)D=!1,t>0?Z(t,!0):te(t,!0);D=!0}}function pe(){if(A.flag)A.flag=!1;else{if(Object.keys(_).length>0)for(let e in _)e>0?ee(e):ne(e);G.hide(),_={}}}function fe(){for(let e in T)"num"!=e&&(de(e),delete T[e]);for(let e in O)"num"!=e&&(de(e),delete O[e]);T={num:1},O={num:-1},_={},z.innerHTML=parseInt(Object.keys(T).length)-1,G.hide()}document.getElementsByTagName("body")[0].style.width=window.innerWidth+"px",document.getElementsByTagName("body")[0].style.height=window.innerHeight+"px",K.new.addEventListener("click",(function(){let e=L(W.color.value),t=B(W.x.value,W.y.value,W.width.value,W.height.value,e.r,e.g,e.b,W.a.value),n=document.createElement("div"),i=T.num;n.style="position:absolute;left:"+t.x+"px;top:"+t.y+"px;width:"+t.width+"px;height:"+t.height+"px;background-color:"+W.color.value+";opacity:"+t.a/255+";box-sizing:border-box;",n.addEventListener("click",ie),n.setAttribute("key",i),C.appendChild(n);let r=document.createElement("div");r.classList.add("tag"),r.innerHTML="■ UI.Box["+i+"]",r.setAttribute("key",i),r.addEventListener("click",ie),I.appendChild(r),T[i]=new w(t,n,r,i),T.num+=1,z.innerHTML=parseInt(Object.keys(T).length)-1,Z(i,!0)})),K.delete.addEventListener("click",ae),K.set.addEventListener("click",ce),K.group.addEventListener("click",(function(e){if(Object.keys(_).length>1){let e=O.num,t=[],n=document.createElement("div"),i=document.createElement("div");i.addEventListener("contextmenu",re),n.classList.add("tag"),i.innerHTML="+ Group["+Math.abs(e)+"]",i.setAttribute("key",e),i.addEventListener("click",ie),n.appendChild(i);for(let i in _)if(i>0){let r=T[i];t.push(r),r.setGroup(e),r.tag.classList.add("hide"),r.tag.classList.add("sonTag"),n.appendChild(r.tag)}else{let r=O[i];for(let i of r.uiBoxList)t.push(i),i.setGroup(e),i.tag.classList.add("hide"),i.tag.classList.add("sonTag"),n.appendChild(i.tag);r.uiBoxList=[],r.domDestroy(),delete O[e]}I.appendChild(n),O[e]=new k(t,n,e),O.num-=1,se(),G.setBox(O[e]),te(e,!0)}else window.alert("打组失败！仅可对 <2个及以上> 数目的box/群组 进行打组！")})),K.clone.addEventListener("click",ge),K.ungroup.addEventListener("click",(function(){if(Object.keys(_).length>0){for(let e in _){if(!(e<0))return void window.alert("解组失败！ 请确认您选择的内容中 存在群组！\n 无法对单个box解组！");{let t=O[e];t.domUnSelected();for(let e of t.uiBoxList)e.group=null,e.tag.classList.remove("sonTag"),e.tag.classList.remove("hide");t.uiBoxList=[],t.domDestroy(),delete O[e],se()}}_={},G.hide()}})),C.addEventListener("click",pe),I.addEventListener("click",pe),q.colorSet.addEventListener("click",(function(){let e="rgb("+q.r.value+","+q.g.value+","+q.b.value+")";C.style.backgroundColor=e,N.style.borderColor=m(e),U.style.borderColor=m(e)})),q.resize.addEventListener("click",(function(){let e=q.width.value,t=q.height.value;e>1300||t>900?alert("画布尺寸请控制在1300x900以内"):(C.style.width=e+"px",C.style.height=t+"px",document.title="uiBox Painter "+e+"x"+t)})),q.scaleSet.addEventListener("click",(function(){C.style.transform="scale("+q.scale.value+")";for(let e of j)e.style.transform="scale("+1/q.scale.value+")";P.style.transform="scale("+1/q.scale.value+")",Q=q.scale.value})),X.clear.addEventListener("click",fe),X.export.addEventListener("click",(function(){let e="LuaCode"+(new Date).toLocaleString()+".lua",t=window.confirm("群组中的ui.Box是否需要以默认名称作为key？\n(否则Group导出为数组类型的sets信息)"),n=function(e,t,n){let i="",r=Object.keys(e);r.splice(r.indexOf("num"),1);let o=Object.keys(t);o.splice(o.indexOf("num"),1),i+="-- GroupSets ↓\n\n";for(let e of o){let o="",s=t[e];""==s.name?o+="Group_"+Math.abs(e)+"={\n":o=s.name+"={\n";for(let e of s.uiBoxList)r.splice(r.indexOf(e.key),1),o+=S(e,"",",\n",n,[s.x,s.y]);o+="}\n",i+=o}i+="-- BoxSets ↓\n\n";for(let t of r)i+=S(e[t],"","\n",!0);return i+="\n\n -- by uiBox Painter",i}(T,O,t);Ee(n,e)})),X.exportComp.addEventListener("click",(function(){let e="LuaCode"+(new Date).toLocaleString()+".lua",t=Me.value.replace(/\s+/g,"");if(""!=t&&(e=t+".lua"),window.confirm("请确认您输入了组件库名称(否则点取消进行输入)\n[按R打开组件命名框输入，然后点击下方确定即可]\n若输入为空，则默认按照单个组件导出，不生成组件库")){let n=function(e,t,n){let i="",r=Object.keys(e);r.splice(r.indexOf("num"),1);let o=Object.keys(t);o.splice(o.indexOf("num"),1),n?(i+=n+'={ui_type="uiTemplates"}\n',n+="."):(i+="\n",n=""),i+="-- CompShop ↓\n\n";for(let e of o){let o="function "+n,s=t[e];""==s.name?o+="Group_"+Math.abs(e)+"()\n\treturn {\n":o+=s.name+"()\n\treturn {\n";for(let e of s.uiBoxList)r.splice(r.indexOf(e.key),1),o+=S(e,"\t",",\n",!1,[s.x,s.y]);o+="\t}\nend\n",i+=o}i+="-- addBox[Error Box] ↓\n\n";for(let t of r)i+=S(e[t],"","\n",!0);return i+="\n\n -- by uiBox Painter",i}(T,O,t);Ee(n,e)}})),X.exportFont.addEventListener("click",(function(){let e="LuaCode"+(new Date).toLocaleString()+".lua",t=Me.value.replace(/\s+/g,"");if(""!=t&&(e=t+".lua"),window.confirm("请确认您输入了组件库名称(否则点取消进行输入)\n[按R打开组件命名框输入，然后点击下方确定即可]\n若输入为空，则默认按照单个组件导出，不生成组件库")){let n=function(e,t,n){let i="",r=Object.keys(e);r.splice(r.indexOf("num"),1);let o=Object.keys(t);o.splice(o.indexOf("num"),1),i+=n?n+'={ui_type="uiFont",_fontSize=?}\n -- 请插入您的字库设计fontSize(最大字高/最大字宽)，否则该字库无法使用\n -- 或者您是想将此子集 合并至别的字库 (如LanaPixel，则按照其fontSize=10设计，然后复制下方fontList内容至LanaPixel.lua文件即可)\nfunction '+n+":_getFset(char)\n\tlocal fset = self[char]\n\tif fset ~= nil then\n\t\tif #fset % 4 == 0 then\n\t\t\ttable.insert(fset, self._fontSize)\n\t\tend\n\t\treturn fset\n\telse\n\t\treturn nil\n\tend\nend\n":"-- 补充"+(n="LanaPixel")+"\n",i+="-- fontList ↓\n";for(let e of o){let o=n+"['",s=t[e];""==s.name?o+="Group_"+Math.abs(e)+"']=":o+=s.name+"']={";for(let e of s.uiBoxList)r.splice(r.indexOf(e.key),1),o+=M(e,[s.x,s.y]);o+=Math.round(s.width)+"}\n",i+=o}i+="-- addBox[Error Box] ↓\n\n";for(let t of r)i+=S(e[t],"","\n",!0);return i+="\n\n -- by uiBox Painter",i}(T,O,t);Ee(n,e)}})),document.addEventListener("keydown",(function(e){console.log("keyCode: ",e.keyCode,"   target:",_),13!=e.keyCode?17!=e.keyCode?67!=e.keyCode?46!=e.keyCode?37!=e.keyCode?38!=e.keyCode?39!=e.keyCode?40!=e.keyCode?82!=e.keyCode?83!=e.keyCode||Le():ze():he(1):ue(1):he(-1):ue(-1):ae():ge():D=!1:ce()})),document.addEventListener("keyup",(function(e){17!=e.keyCode||(D=!0)}));let me=document.getElementById("saveFile"),xe=document.getElementById("openFile"),ye=document.getElementById("importFile"),be=document.getElementById("fileSet"),ve=document.getElementById("imgSet"),we=document.getElementById("importImg"),ke=document.getElementById("clearImg");function Be(e,t,n){let i=[];for(let r of t)i.push(n+e.indexOf(r.toString()));return i}function Le(){if(1==Object.keys(T).length)return void window.alert("您还未作任何更改，不必进行保存操作 ->,<-");let e="uiBoxPainter"+(new Date).toLocaleString()+".json",t={};for(let e in T){if("num"==e)continue;let n=T[e],i={name:n.name,x:n.x,y:n.y,width:n.width,height:n.height,r:n.r,g:n.g,b:n.b,a:n.a,group:n.group,key:e};t[e]=i}for(let e in O){if("num"==e)continue;let n=O[e],i={name:n.name,x:n.x,y:n.y,width:n.width,height:n.height,key:e,uiBoxList:n.getSonKey()};t[e]=i}t=JSON.stringify(t),Ee(t,e)}function Ee(e,t){let n=new Blob([e],{type:"text/plain;charset=utf-8"}),i=document.createElement("a");i.download=t,i.href=URL.createObjectURL(n),document.getElementsByTagName("body")[0].appendChild(i),i.click(),i.remove()}function Se(e){let t=T.num,n=E(e),i=document.createElement("div");i.style="position:absolute;left:"+e.x+"px;top:"+e.y+"px;width:"+e.width+"px;height:"+e.height+"px;background-color:"+n+";opacity:"+e.a/255+";box-sizing:border-box;",i.addEventListener("click",ie),i.setAttribute("key",t),C.appendChild(i);let r=document.createElement("div");return r.classList.add("tag"),r.innerHTML="■ UI.Box["+t+"]",r.setAttribute("key",t),r.addEventListener("click",ie),I.appendChild(r),T[t]=new w(e,i,r,t),T.num+=1,e.name&&T[t].setName(e.name),z.innerHTML=parseInt(Object.keys(T).length)-1,Z(t,!0),t}xe.addEventListener("click",(function(){window.confirm("确定导入现有吗？\n导入后当前工作将被清空")&&(be.click(),fe())})),ye.addEventListener("click",(function(){be.click()})),be.addEventListener("change",(function(){if(0==be.files.length)return;let e=new FileReader,t=null;e.readAsText(be.files[0],"utf-8"),be.value="";let n=T.num,i=[];e.onload=()=>{t=JSON.parse(e.result);for(let e in t)e>0?(i.push(e),Se(t[e])):le(Be(i,t[e].uiBoxList,n),t[e].name)}})),me.addEventListener("click",Le),we.addEventListener("click",(function(){ve.click()})),ve.addEventListener("change",(function(){if(0==ve.files.length)return;let e=URL.createObjectURL(ve.files[0]);C.style.backgroundImage='url("'+e+'")',be.value=""})),ke.addEventListener("click",(function(){C.style.backgroundImage=""})),document.getElementById("bilibili").addEventListener("click",(()=>{window.open("https://space.bilibili.com/9539642")}));let Me=document.getElementById("setName"),Ce=document.getElementById("rename"),Ie=document.getElementsByClassName("renameBar")[0];function ze(){Ie.style.border="",Ie.offsetTop<-10?Ie.style.top="-10px":Ie.style.top="-70px"}Me.addEventListener("keydown",(e=>{e.stopPropagation()})),Me.addEventListener("click",(e=>{e.stopPropagation()})),Ce.addEventListener("click",(function(e){e.stopPropagation(),G.uiBox&&G.uiBox.setName(Me.value)})),Ie.addEventListener("click",ze);let Te=document.getElementById("help"),Oe=document.getElementById("helpBack");Te.addEventListener("click",(()=>{document.getElementsByClassName("mask")[0].style.display="flex"})),Oe.addEventListener("click",(()=>{document.getElementsByClassName("mask")[0].style.display="none"}))})()})();