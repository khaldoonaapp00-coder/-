
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="theme-color" content="#10100e">
<title>أنوار أهل البيت</title>

<style>
*{box-sizing:border-box}
body{
 margin:0;background:#10100e;color:#f5e9c8;
 font-family:Tahoma,Arial,sans-serif
}
header{
 padding:28px 16px;text-align:center;
 background:linear-gradient(135deg,#242017,#10100e);
 border-bottom:1px solid #9c7b36
}
header h1{color:#e9c76a;margin:5px}
header p{color:#c9bea1}
.container{max-width:800px;margin:auto;padding:16px}
input,select,textarea{
 width:100%;padding:13px;margin:7px 0;
 border:1px solid #65532c;border-radius:12px;
 background:#1c1b17;color:#fff;font-size:15px
}
button{
 padding:12px 15px;border:0;border-radius:10px;
 background:#b99742;color:#17140c;
 font-weight:bold;cursor:pointer;margin:4px
}
.tabs{display:flex;flex-wrap:wrap;gap:5px;margin:14px 0}
.tabs button{flex:1;min-width:90px}
.card{
 background:#1c1b17;border:1px solid #514426;
 border-radius:15px;padding:17px;margin:12px 0
}
.card h3{color:#e9c76a;margin-top:0}
.dua-text{
 white-space:pre-line;line-height:2.2;
 font-size:18px;color:#f4ead4
}
.small{font-size:12px;color:#b8ad93}
audio{width:100%;margin-top:12px}
.hidden{display:none}
footer{text-align:center;padding:25px;color:#a89c80}
</style>
</head>

<body>
<header>
 <div style="font-size:38px">☪</div>
 <h1>أنوار أهل البيت</h1>
 <p>الأدعية والزيارات والأذكار والأصوات الروحانية</p>
</header>

<main class="container">
 <input id="search" placeholder="🔍 ابحث عن دعاء أو زيارة..."
 oninput="render()">

 <div class="tabs">
  <button onclick="setCategory('الكل')">الكل</button>
  <button onclick="setCategory('أدعية')">الأدعية</button>
  <button onclick="setCategory('زيارات')">الزيارات</button>
  <button onclick="setCategory('أذكار')">الأذكار</button>
  <button onclick="showFavorites()">⭐ المفضلة</button>
  <button onclick="showAudio()">🎧 الصوتيات</button>
 </div>

 <section id="library"></section>

 <section id="audioSection" class="card hidden">
  <h3>🎧 مشغل الأدعية الصوتية</h3>
  <p>ضع رابط ملف صوتي مباشر بصيغة MP3 أو رابطاً يدعم التشغيل.</p>
  <input id="audioUrl" type="url" placeholder="https://example.com/dua.mp3">
  <button onclick="playAudio()">▶ تشغيل الصوت</button>
  <audio id="player" controls></audio>
  <p class="small">
   يجب أن يكون الرابط مباشراً لملف صوتي، وأن يسمح الموقع بالتشغيل.
   هذا المشغل لا يوفّر التسجيلات تلقائياً.
  </p>
 </section>
</main>

<footer>
 اللهم صلِّ على محمد وآل محمد
</footer>

<script>
const duas = [
 {
  title:"دعاء الفرج",
  category:"أدعية",
  text:"اللهم كن لوليك الحجة بن الحسن، صلواتك عليه وعلى آبائه، في هذه الساعة وفي كل ساعة، ولياً وحافظاً، وقائداً وناصراً، ودليلاً وعيناً، حتى تسكنه أرضك طوعاً، وتمتعه فيها طويلاً."
 },
 {
  title:"دعاء كميل",
  category:"أدعية",
  text:"اللهم إني أسألك برحمتك التي وسعت كل شيء، وبقوتك التي قهرت بها كل شيء، وخضع لها كل شيء، وذل لها كل شيء، وبجبروتك التي غلبت بها كل شيء."
 },
 {
  title:"دعاء التوسل",
  category:"أدعية",
  text:"اللهم إني أسألك وأتوجه إليك بنبيك نبي الرحمة محمد صلى الله عليه وآله. يا أبا القاسم يا رسول الله، يا إمام الرحمة، يا سيدنا ومولانا، إنا توجهنا واستشفعنا وتوسلنا بك إلى الله."
 },
 {
  title:"دعاء العهد",
  category:"أدعية",
  text:"اللهم رب النور العظيم، ورب الكرسي الرفيع، ورب البحر المسجور، ومنزل التوراة والإنجيل والزبور، ورب الظل والحرور، ومنزل القرآن العظيم، ورب الملائكة المقربين والأنبياء والمرسلين."
 },
 {
  title:"دعاء الصباح",
  category:"أدعية",
  text:"اللهم يا من دلع لسان الصباح بنطق تبلجه، وسرح قطع الليل المظلم بغياهب تلجلجه، وأتقن صنع الفلك الدوار في مقادير تبرجه."
 },
 {
  title:"دعاء الندبة",
  category:"أدعية",
  text:"الحمد لله رب العالمين، وصلى الله على سيدنا محمد نبيه وآله وسلم تسليماً. اللهم لك الحمد على ما جرى به قضاؤك في أوليائك."
 },
 {
  title:"زيارة عاشوراء",
  category:"زيارات",
  text:"السلام عليك يا أبا عبد الله، السلام عليك يا ابن رسول الله، السلام عليك يا ابن أمير المؤمنين وابن سيد الوصيين، السلام عليك يا ابن فاطمة سيدة نساء العالمين."
 },
 {
  title:"زيارة أمين الله",
  category:"زيارات",
  text:"السلام عليك يا أمين الله في أرضه وحجته على عباده، السلام عليك يا أمير المؤمنين. أشهد أنك جاهدت في الله حق جهاده، وعملت بكتابه، واتبعت سنن نبيه."
 },
 {
  title:"الزيارة الجامعة الكبيرة",
  category:"زيارات",
  text:"السلام عليكم يا أهل بيت النبوة، وموضع الرسالة، ومختلف الملائكة، ومهبط الوحي، ومعدن الرحمة، وخزان العلم، ومنتهى الحلم، وأصول الكرم."
 },
 {
  title:"التسبيحات",
  category:"أذكار",
  text:"سبحان الله، والحمد لله، ولا إله إلا الله، والله أكبر."
 },
 {
  title:"الصلاة على محمد وآل محمد",
  category:"أذكار",
  text:"اللهم صلِّ على محمد وآل محمد."
 }
];

let category="الكل";
let favorites=JSON.parse(localStorage.getItem("duaFavorites")||"[]");
let favoritesOnly=false;

function setCategory(c){
 category=c;
 favoritesOnly=false;
 document.getElementById("audioSection").classList.add("hidden");
 render();
}

function showFavorites(){
 favoritesOnly=true;
 category="الكل";
 render();
}

function showAudio(){
 document.getElementById("audioSection").classList.remove("hidden");
 document.getElementById("audioSection").scrollIntoView({behavior:"smooth"});
}

function toggleFavorite(title){
 if(favorites.includes(title)){
  favorites=favorites.filter(x=>x!==title);
 }else{
  favorites.push(title);
 }
 localStorage.setItem("duaFavorites",JSON.stringify(favorites));
 render();
}

function render(){
 const query=document.getElementById("search").value.trim();
 const library=document.getElementById("library");
 const filtered=duas.filter(d=>{
  const matchCategory=category==="الكل"||d.category===category;
  const matchSearch=(d.title+" "+d.text).includes(query);
  const matchFav=!favoritesOnly||favorites.includes(d.title);
  return matchCategory&&matchSearch&&matchFav;
 });

 library.innerHTML="";
 if(filtered.length===0){
  library.innerHTML='<div class="card">ما لقينا نتائج. جرّب كلمة ثانية.</div>';
  return;
 }

 filtered.forEach(d=>{
  const card=document.createElement("article");
  card.className="card";

  const title=document.createElement("h3");
  title.textContent=d.title;

  const type=document.createElement("p");
  type.className="small";
  type.textContent=d.category;

  const text=document.createElement("div");
  text.className="dua-text";
  text.textContent=d.text;

  const fav=document.createElement("button");
  fav.textContent=favorites.includes(d.title)?"⭐ إزالة من المفضلة":"☆ أضف للمفضلة";
  fav.onclick=()=>toggleFavorite(d.title);

  const copy=document.createElement("button");
  copy.textContent="📋 نسخ النص";
  copy.onclick=async()=>{
   try{
    await navigator.clipboard.writeText(d.title+"\n\n"+d.text);
    copy.textContent="تم النسخ ✓";
   }catch(e){
    alert("تعذر النسخ من هذا المتصفح.");
   }
  };

  card.append(title,type,text,fav,copy);
  library.appendChild(card);
 });
}

function playAudio(){
 const url=document.getElementById("audioUrl").value.trim();
 const player=document.getElementById("player");
 if(!url){
  alert("أدخل رابط ملف صوتي أولاً");
  return;
 }
 try{
  const parsed=new URL(url);
  if(!["http:","https:"].includes(parsed.protocol)){
   throw new Error("Invalid URL");
  }
  player.src=parsed.href;
  player.play().catch(()=>alert("تعذر التشغيل. تأكد من الرابط واتصال الإنترنت."));
 }catch(e){
  alert("الرابط غير صحيح");
 }
}

render();
</script>
</body>
</html>