import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  // Mesaj listesi
  final List<Map<String, String>> messages =[
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, yaşama hakkına sahiptir. (Anayasa md. 17)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kimseye işkence, eziyet ve insan onuruna aykırı ceza uygulanamaz. (Anayasa md. 17)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Hiç kimse zorla çalıştırılamaz. Angarya yasaktır. (Anayasa md. 18)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes kişi özgürlüğü ve güvenliğine sahiptir. (Anayasa md. 19)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Tutuklanan kişiler, en geç 48 saat içinde hâkim önüne çıkarılmak zorundadır. (Anayasa md. 19)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Tutuklanan kişilerin yakınlarına durum hemen bildirilir. (Anayasa md. 19)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, kısa sürede serbest bırakılma veya mahkemeye başvurma hakkına sahiptir. (Anayasa md. 19)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes özel hayatına ve aile hayatına saygı gösterilmesini isteme hakkına sahiptir. (Anayasa md. 20)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes kişisel verilerinin korunmasını isteme hakkına sahiptir. (Anayasa md. 20)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kimsenin konutuna hâkim kararı olmadan girilemez. (Anayasa md. 21)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Haberleşme özgürlüğü esastır; telefon ve mesajlar hâkim kararı olmadan dinlenemez. (Anayasa md. 22)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, dilediği yerde yerleşme ve seyahat etme özgürlüğüne sahiptir. (Anayasa md. 23)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes vicdan, dinî inanç ve kanaat özgürlüğüne sahiptir. (Anayasa md. 24)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes düşünce ve kanaatlerini söz, yazı, resim veya başka yollarla tek başına veya toplu olarak açıklama hakkına sahiptir. (Anayasa md. 25-26)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, bilim ve sanatı serbestçe öğrenme ve öğretme, açıklama, yayma ve bu alanlarda her türlü araştırma hakkına sahiptir. (Anayasa md. 27)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, önceden izin almadan toplantı ve gösteri yürüyüşü düzenleme hakkına sahiptir. (Anayasa md. 34)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, önceden izin almaksızın dernek kurma hakkına sahiptir. (Anayasa md. 33)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes mülkiyet hakkına sahiptir. (Anayasa md. 35)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, meşrû vasıta ve yollardan faydalanmak suretiyle yargı mercileri önünde davacı veya davalı olarak iddia ve savunma ile adil yargılanma hakkına sahiptir. (Anayasa md. 36)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Hiç kimse, kanunen tabi olduğu mahkemeden başka bir merci önüne çıkarılamaz. (Anayasa md. 37)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Suç ve cezalar, kanunla belirlenir. (Anayasa md. 38)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kimse, işlendiği zaman yürürlükte bulunan kanunun suç saymadığı bir fiilden dolayı cezalandırılamaz. (Anayasa md. 38)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Suçluluğu hükmen sabit oluncaya kadar, kimse suçlu sayılamaz. (Masumiyet Karinesi) (Anayasa md. 38)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kimse, kendisini veya kanunda gösterilen yakınlarını suçlayan bir beyanda bulunmaya zorlanamaz. (Anayasa md. 38)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Yasa dışı elde edilen bulgular, delil olarak kullanılamaz. (Anayasa md. 38)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, kamu hizmetlerine girme hakkına sahiptir. (Anayasa md. 70)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, seçme, seçilme ve siyasi faaliyette bulunma hakkına sahiptir. (Anayasa md. 67)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Vatandaşlar, bilgi edinme ve kamu denetçisine başvurma hakkına sahiptir. (Anayasa md. 74)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Çalışma, herkesin hakkı ve ödevidir. (Anayasa md. 49)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kimse, yaşına, cinsiyetine ve gücüne uymayan işlerde çalıştırılamaz. (Anayasa md. 50)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Devlet, çalışanların hayat seviyesini yükseltmek, çalışma hayatını geliştirmek için çalışanları korur ve çalışmayı destekler. (Anayasa md. 49)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Sendika kurma ve sendikaya üye olma hakkı güvence altındadır. (Anayasa md. 51)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Toplu iş sözleşmesi yapma hakkı güvence altındadır. (Anayasa md. 53)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "İşçiler grev hakkına sahiptir. (Anayasa md. 54)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkesin sosyal güvenlik hakkı vardır. (Anayasa md. 60)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, sağlıklı ve dengeli bir çevrede yaşama hakkına sahiptir. (Anayasa md. 56)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkesin eğitim ve öğrenim hakkı vardır. (Anayasa md. 42)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkesin konut hakkı vardır. (Anayasa md. 57)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Aile, Türk toplumunun temelidir. (Anayasa md. 41)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Çocukların korunması ve ihtiyaçlarının karşılanması devletin görevidir. (Anayasa md. 41)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Devlet, tüketiciyi koruyucu ve aydınlatıcı tedbirler alır. (Anayasa md. 172)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Yabancıların Türkiye'de sahip olduğu temel hak ve özgürlükler, uluslararası hukuka uygun olarak kanunla düzenlenir. (Anayasa md. 16)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Devlet, engellilerin topluma kazandırılmasını sağlayacak tedbirleri alır. (Anayasa md. 61)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Devlet, harp ve vazife şehitlerinin dul ve yetimleriyle, malul ve gazileri korur. (Anayasa md. 61)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Herkes, kamu giderlerini karşılamak üzere, malî gücüne göre vergi ödemekle yükümlüdür. (Anayasa md. 73)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Kanunsuz emir yerine getirilmez. (Anayasa md. 137)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Hiçbir kimse ve organ, kaynağını Anayasadan almayan bir Devlet yetkisi kullanamaz. (Anayasa md. 6)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Türkiye Cumhuriyeti, bir hukuk Devletidir. (Anayasa md. 2)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Devlet, her türlü istismara karşı çocukları korur. (Anayasa md. 41)"
    },
    {
      "title": "Türkiye Cumhuriyeti Anayasası (Seçmeler)",
      "body": "Vatandaşlıktan çıkarılma kararlarına karşı yargı yolu açıktır. (Anayasa md. 66)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Bir sözleşme tarafların karşılıklı rızasıyla kurulur. (Borçlar Kanunu md. 1)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sözleşmeler, kanunda aksi belirtilmedikçe, herhangi bir şekil şartına bağlı değildir. (Borçlar Kanunu md. 12)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sözleşmenin içeriği, kanunun emredici hükümlerine, ahlaka, kamu düzenine, kişilik haklarına aykırı veya imkansız olamaz. (Borçlar Kanunu md. 27)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sözleşme kurulurken esaslı konularda hata yapılması durumunda sözleşme iptal edilebilir. (Borçlar Kanunu md. 30)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Bir tarafın aldatılması (hile) sonucu yapılan sözleşme iptal edilebilir. (Borçlar Kanunu md. 36)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Tehdit (korkutma) altında yapılan sözleşme, korkutulan kişi için bağlayıcı değildir. (Borçlar Kanunu md. 37)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Aşırı yararlanma (gabin) durumunda, zarar gören, sözleşmeyi iptal edebilir. (Borçlar Kanunu md. 28)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Borçlu, borcunu ifa etmezse alacaklı, borcun ifasını veya uğradığı zararın tazminini isteyebilir. (Borçlar Kanunu md. 112)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Borçlunun temerrüde düşmesi (gecikmesi) durumunda, alacaklı ilave zararlarını da talep edebilir. (Borçlar Kanunu md. 118)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Haksız fiil sonucu başkasına zarar veren, bu zararı gidermekle yükümlüdür. (Borçlar Kanunu md. 49)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Haksız fiil sonucu zarar gören, uğradığı manevi zararın tazminini de talep edebilir. (Borçlar Kanunu md. 56)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Kusursuz sorumluluk hallerinde (örn: hayvan bulunduranın sorumluluğu) kusuru olmasa bile zararı giderme yükümlülüğü doğabilir. (Borçlar Kanunu md. 66-71)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sebepsiz zenginleşen (haksız yere malvarlığı artan), bu zenginleşmeyi iade etmekle yükümlüdür. (Borçlar Kanunu md. 77)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Satıcı, ayıplı (kusurlu) mal teslim ettiğinde, alıcının hakları (onarım, bedel indirimi, sözleşmeden dönme vb.) vardır. (Borçlar Kanunu md. 219)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Ayıp, alıcının malı teslim alırken incelemesiyle ortaya çıkacak türden değilse (gizli ayıp), alıcı bunu hemen bildirmelidir. (Borçlar Kanunu md. 223)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Kiracı, kiralananı sözleşmeye uygun kullanmak zorundadır. (Borçlar Kanunu md. 316)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Kiraya veren, kiralananı kiracıya teslim etmek ve kullanıma elverişli durumda bulundurmak zorundadır. (Borçlar Kanunu md. 301)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Konut ve çatılı işyeri kiralarında kiracı, sözleşme süresinin bitiminden en az 15 gün önce bildirimde bulunmadıkça, sözleşme aynı şartlarla 1 yıl uzamış sayılır. (Borçlar Kanunu md. 347)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Kiraya veren, kiracıya karşı sadece kanunda sayılan sınırlı sebeplerle (ihtiyaç, yeniden inşa vb.) tahliye davası açabilir. (Borçlar Kanunu md. 350-352)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Vekil (temsilci), vekâlet verenin (müvekkil) menfaatine ve iradesine uygun hareket etmek zorundadır. (Borçlar Kanunu md. 505)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Vekil, müvekkilden aldığı her şeyi iade etmek ve hesap vermekle yükümlüdür. (Borçlar Kanunu md. 508)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Eser (İnşaat, yazılım vb.) sözleşmesinde, işi yapan (yüklenici), eseri sözleşmeye uygun ve özenle yapmak zorundadır. (Borçlar Kanunu md. 471)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "İş sahibi, eserdeki ayıpları (kusurları) bildirmek zorundadır; aksi halde eseri kabul etmiş sayılır. (Borçlar Kanunu md. 474)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Kefil, borçlu borcunu ödemediği takdirde, borçtan alacaklıya karşı sorumlu olur. (Borçlar Kanunu md. 581)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Tüketici kredisi sözleşmeleri yazılı şekilde yapılmak zorundadır. (Borçlar Kanunu md. 48)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Alacaklı, borçluyu zarara uğratacak şekilde hukuka aykırı olarak alacağını başkasına devredemez. (Borçlar Kanunu md. 182)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Borcun ifası imkânsız hale gelirse ve borçlu bundan kusursuzsa, borç sona erer. (Borçlar Kanunu md. 136)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sözleşme yapma vaadi (ön sözleşme) yazılı yapılmalıdır ve bu vaade uymayan taraf tazminat ödemek zorunda kalabilir. (Borçlar Kanunu md. 29)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Özenli bir kişi tarafından dahi öngörülemeyen olağanüstü durumlarda (aşırı ifa güçlüğü) hâkim sözleşmeyi uyarlayabilir. (Borçlar Kanunu md. 138)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Ayıplı hizmet sunulması durumunda da benzer haklar (sözleşmeden dönme, bedel indirimi) kullanılabilir. (Borçlar Kanunu md. 470)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Bağışlama vaadi yazılı yapılmadıkça geçerli olmaz. (Borçlar Kanunu md. 288)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "İlan yoluyla ödül sözü veren, sözünü yerine getirmekle yükümlüdür. (Borçlar Kanunu md. 66)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Birden çok borçlu varsa ve borcun bölünebilir olduğu sözleşmede belirtilmemişse, borçlular borcun tamamından sorumludur (müteselsil borçluluk). (Borçlar Kanunu md. 162)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Sözleşmede belirlenen ceza koşulu (cezai şart), aşırı yüksekse hâkim tarafından indirilebilir. (Borçlar Kanunu md. 182)"
    },
    {
      "title": "Türk Borçlar Kanunu (Seçmeler)",
      "body": "Zarar görenin (mağdur) zararın oluşmasında kusuru varsa, tazminat miktarı azaltılabilir. (Borçlar Kanunu md. 52)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel veriler yalnızca hukuka uygun olarak işlenebilir. (KVKK md. 4)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel veriler, belirli, açık ve meşru amaçlar için işlenmelidir. (KVKK md. 4)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel veriler, işlendikleri amaçla bağlantılı, sınırlı ve ölçülü olmalıdır. (KVKK md. 4)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel verilerin doğru ve gerektiğinde güncel olması esastır. (KVKK md. 4)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel veriler, ilgili mevzuatta öngörülen veya işlendikleri amaç için gerekli olan süre kadar muhafaza edilmelidir. (KVKK md. 4)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel veriler, ilgili kişinin açık rızası olmaksızın işlenemez. (KVKK md. 5)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusunun hukuki yükümlülüğünü yerine getirmesi için zorunlu olması halinde, açık rıza aranmaz. (KVKK md. 5)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "İlgili kişinin temel hak ve özgürlüklerine zarar vermemek kaydıyla, veri sorumlusunun meşru menfaati için veri işlenmesi zorunluysa, açık rıza aranmaz. (KVKK md. 5)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kanunlarda açıkça öngörülmesi halinde, açık rıza olmaksızın veri işlenebilir. (KVKK md. 5)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Bir sözleşmenin kurulması veya ifasıyla doğrudan doğruya ilgili olması kaydıyla, sözleşmenin taraflarına ait kişisel verilerin işlenmesi zorunluysa, açık rıza aranmaz. (KVKK md. 5)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Sağlık ve cinsel hayat dışındaki özel nitelikli kişisel veriler, kanunlarda öngörülen hallerde açık rıza olmaksızın işlenebilir. (KVKK md. 6)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Sağlık ve cinsel hayata ilişkin özel nitelikli kişisel veriler ancak kamu sağlığının korunması, koruyucu hekimlik, tıbbî teşhis, tedavi ve bakım hizmetlerinin yürütülmesi amacıyla, sır saklama yükümlülüğü altında bulunan kişiler tarafından işlenebilir. (KVKK md. 6)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu veya yetkilendirdiği kişi, ilgili kişileri aydınlatma yükümlülüğünü yerine getirmek zorundadır. (KVKK md. 10)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu, verilerin hangi amaçla işleneceğini ilgili kişiye bildirmelidir. (KVKK md. 10)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu, işlenen kişisel verileri kimlere ve hangi amaçla aktarabileceğini bildirmelidir. (KVKK md. 10)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, kişisel verilerinin işlenip işlenmediğini öğrenme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, kişisel verileri işlenmişse buna ilişkin bilgi talep etme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, verilerin işlenme amacını ve bu amaçlara uygun kullanılıp kullanılmadığını öğrenme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, kişisel verilerin aktarıldığı üçüncü kişileri bilme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, eksik veya yanlış işlenmiş verilerin düzeltilmesini isteme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, verilerin silinmesini veya yok edilmesini isteme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Herkes, işlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle aleyhine bir sonucun ortaya çıkmasına itiraz etme hakkına sahiptir. (KVKK md. 11)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu, verilerin hukuka aykırı olarak işlenmesini önlemek ve güvenliğini sağlamak için gerekli tüm tedbirleri almak zorundadır. (KVKK md. 12)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "İşlenen verilerin kanuni olmayan yollarla başkaları tarafından elde edilmesi halinde, veri sorumlusu bu durumu Kurul'a ve ilgili kişiye en kısa sürede bildirir. (KVKK md. 12)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "İlgili kişi, haklarını kullanmak için veri sorumlusuna başvurmak zorundadır. (KVKK md. 13)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu, başvuruyu en kısa sürede ve en geç 30 gün içinde cevaplandırır. (KVKK md. 13)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusunun cevabını yetersiz bulan veya süresinde cevap alamayan ilgili kişi, Kurul'a şikâyette bulunabilir. (KVKK md. 14)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel verilerin yurt dışına aktarılması, kural olarak ilgili kişinin açık rızasına bağlıdır. (KVKK md. 9)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Açık rıza olmaksızın yurt dışına veri aktarımı, yeterli korumanın bulunduğu ülkelere veya Kurul izniyle yapılabilir. (KVKK md. 9)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kişisel verilerin işlenmesini gerektiren sebepler ortadan kalktığında, veriler silinir, yok edilir veya anonim hale getirilir. (KVKK md. 7)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumluları, Veri Sorumluları Siciline (VERBİS) kaydolmak zorundadır (Kurul tarafından belirlenen istisnalar hariç). (KVKK md. 16)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Kanun hükümlerine aykırı hareket edenler hakkında idari para cezası uygulanır. (KVKK md. 18)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri sorumlusu, kişisel verilerin güvenliğinden müştereken sorumludur. (KVKK md. 12)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Özel nitelikli kişisel verilerin işlenmesinde, Kurul'un belirlediği ek tedbirler alınmalıdır. (KVKK md. 6)"
    },
    {
      "title": "Kişisel Verilerin Korunması Kanunu (Seçmeler)",
      "body": "Veri işleyenler, veri sorumlusunun talimatlarına uygun hareket etmek zorundadır. (KVKK md. 12)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Tacir, basiretli bir iş adamı gibi hareket etmek zorundadır. (TTK md. 18)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Tacir, ticari işletmesiyle ilgili tüm faaliyetlerinde dürüstlük kuralına uymak zorundadır. (TTK md. 20)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Tacir, ticari defter tutmak ve belgeleri düzenli saklamak zorundadır. (TTK md. 64)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Tacir, işletmesini Ticaret Sicili'ne tescil ettirmek zorundadır. (TTK md. 40)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Tacir, her türlü borcundan dolayı bütün mal varlığıyla sorumludur. (TTK md. 18)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Fatura ve teyit mektubuna 8 gün içinde itiraz edilmezse, içeriği kabul edilmiş sayılır. (TTK md. 21)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Ticari işlerde faiz oranı serbestçe belirlenebilir, ancak aşırı yüksek olamaz. (TTK md. 8)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Haksız rekabet yapan, zararın tazminini ödemek zorunda kalır. (TTK md. 54)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirket ortakları, şirketin borçlarından dolayı (limited ve anonim şirketlerde kural olarak) sorumlu değildir. (TTK md. 329, 570)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Anonim şirket pay sahipleri, sadece taahhüt ettikleri sermaye payları kadar sorumludur. (TTK md. 329)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Limited şirket ortakları, şirkete koymayı taahhüt ettikleri esas sermaye payları kadar sorumludur. (TTK md. 570)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirketler, kanunda öngörülen organlara (Genel Kurul, Yönetim Kurulu vb.) sahip olmak zorundadır. (TTK md. 359, 616)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirket genel kurul toplantıları, tüm ortakların bilgi edinme hakkı ve oy kullanma hakkı gözetilerek yapılmalıdır. (TTK md. 407, 617)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Yönetim kurulu üyeleri, şirketin menfaatini gözetmekle yükümlüdür. (TTK md. 369)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirketler, yıllık faaliyet raporlarını ve finansal tablolarını hazırlamak zorundadır. (TTK md. 514)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Çek, bono ve poliçe gibi kıymetli evrak, kanunda öngörülen şekil şartlarına uygun düzenlenmelidir. (TTK md. 780, 671)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Poliçe veya bonoyu imzalayan kişi, bedelini ödemekten sorumludur. (TTK md. 671)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Taşıma işini üstlenen taşıyıcı, malın zıyaından (kaybolmasından) veya hasarından sorumludur. (TTK md. 860)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Sigorta sözleşmesi, yazılı yapılmak zorundadır. (TTK md. 1420)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Sigortacı, primin ödenmesinden itibaren rizikoyu (riski) üstlenir. (TTK md. 1431)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Sigorta ettiren, teklif anında bildiği veya bilmesi gereken tüm önemli hususları sigortacıya bildirmek zorundadır. (TTK md. 1439)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirket ortakları, şirket işleri hakkında bilgi isteme ve inceleme hakkına sahiptir. (TTK md. 411)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Ticaret unvanı, tescil edildiği yere özgüdür ve başkası tarafından kullanılamaz. (TTK md. 52)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Ticari defterler ve belgeler 10 yıl saklanmak zorundadır. (TTK md. 82)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Anonim şirket genel kurulu kararları, kanuna aykırıysa iptal edilebilir. (TTK md. 445)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Ticari temsilci (vekil), ticari işletmenin olağan işlerini yapmak için yetkilidir. (TTK md. 450)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Komisyoncu, malı kendi adına ancak müvekkili hesabına alır veya satar. (TTK md. 532)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "TTK uyarınca tacirler arasındaki uyuşmazlıklarda, ticari örf ve adetler dikkate alınır. (TTK md. 1)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Birleşme, bölünme ve tür değiştirme işlemleri kanunda belirtilen prosedürlere uygun yapılmalıdır. (TTK md. 134-180)"
    },
    {
      "title": "Türk Ticaret Kanunu (Seçmeler)",
      "body": "Şirketlerin sermayesi, asgari tutarların (örn. A.Ş. için 50.000 TL) altında olamaz. (TTK md. 330)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, ayıplı mal veya hizmetten sorumlu tutulamaz. (TKHK md. 11)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, ayıplı mal karşısında bedel indirimi, ücretsiz onarım, malın değişimi veya sözleşmeden dönme haklarından birini seçebilir. (TKHK md. 11)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Ayıplı malın ücretsiz onarımı veya malın yenisi ile değişimi tercih edildiğinde, bu talepler satıcı tarafından en fazla 30 iş günü içinde yerine getirilmelidir. (TKHK md. 11)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, mesafeli sözleşmelerden (internet, telefon vb.) 14 gün içinde cayma hakkına sahiptir. (TKHK md. 48)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Cayma hakkı kullanılan mesafeli sözleşmelerde satıcı, aldığı tüm ödemeleri 14 gün içinde iade etmek zorundadır. (TKHK md. 48)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Taksitli satışlarda, tüketici borcunu erken öderse faiz indirimi yapılır. (TKHK md. 17)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Konut finansmanı (ipotekli konut kredisi) sözleşmelerinde de tüketici, borcunu erken kapatırsa faiz indirimi talep edebilir. (TKHK md. 37)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici kredisi sözleşmesi imzalamadan önce, tüketiciye ön bilgilendirme formu verilmesi zorunludur. (TKHK md. 22)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Süreli yayın kuruluşları (gazete, dergi), satış kampanyası düzenlerken ilan edilen taahhütleri yerine getirmek zorundadır. (TKHK md. 60)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Satış sonrası hizmetler için satıcı, TSE belgeli servis sağlamak zorundadır. (TKHK md. 58)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Satıcı, garanti süresi içinde, onarım süresinin 10 iş gününü aşması halinde, tüketiciye kullanabileceği başka bir mal temin etmek zorundadır. (TKHK md. 56)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Malın tamir süresi 20 iş gününü aşamaz. (TKHK md. 56)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Ayıbın ortaya çıktığı tarihten itibaren 6 ay içinde onarım veya değişim talebi yerine getirilmezse, tüketici sözleşmeden dönebilir. (TKHK md. 11)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, ayıplı mal ve hizmetlerde, bedeli 100.000 TL'nin altındaki uyuşmazlıklar için Tüketici Hakem Heyetlerine başvurabilir. (TKHK md. 68)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, hakem heyeti kararını yerine getirmeyen satıcı veya sağlayıcıyı icraya verebilir. (TKHK md. 70)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, iş yeri dışında kurulan (kapıdan satış gibi) sözleşmelerden 14 gün içinde cayma hakkına sahiptir. (TKHK md. 47)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Devre tatil sözleşmelerinde de 14 günlük cayma hakkı süresi mevcuttur. (TKHK md. 50)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "İndirimli satışlarda indirimli satış fiyatı, indirim oranı, indirimin başlangıç ve bitiş tarihi açıkça belirtilmelidir. (TKHK md. 54)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, satın aldığı malın garanti belgesini talep etme hakkına sahiptir. (TKHK md. 55)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketicinin onarım talebi kabul edildiğinde, malın garanti süresine onarımda geçen süre eklenir. (TKHK md. 56)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Abonelik sözleşmeleri, taahhüt süresi dolsa bile, tüketici dilediği zaman feshedebilir. (TKHK md. 52)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Fesih talebi, yazılı veya kalıcı veri saklayıcısı ile yapılır ve sağlayıcı 7 gün içinde feshi yerine getirmek zorundadır. (TKHK md. 52)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketiciden talep edilebilecek cayma bedeli (cezai şart), taahhüt süresinin kalanına ait hizmet bedelini aşamaz. (TKHK md. 52)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Ticari reklamların, dürüst ve doğru olması esastır. (TKHK md. 61)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Çocuklara yönelik reklamlar, çocukların tecrübesizliğinden yararlanılamaz. (TKHK md. 61)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Reklam Kurulu, aldatıcı reklamları durdurabilir ve para cezası verebilir. (TKHK md. 63)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, haksız şart içeren sözleşmelere karşı korunur. (TKHK md. 5)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Haksız sözleşme şartları tüketici aleyhine hüküm doğurmaz. (TKHK md. 5)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Satıcı, tüketiciye sözleşme öncesinde açık bilgilendirme yapmak zorundadır. (TKHK md. 49)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, kredi kartı sözleşmesini istediği zaman feshedebilir. (TKHK md. 24)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, bankadan aldığı krediyi erken kapatırsa faiz indirimi yapılması zorunludur. (TKHK md. 24)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Paket tur sözleşmelerinde tüketici, ağır değişiklik olursa sözleşmeden dönebilir. (TKHK md. 51)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Paket tur iptal edilirse, tüketiciye yapılan ödemeler 14 gün içinde iade edilmelidir. (TKHK md. 51)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, ayıplı mal nedeniyle uğradığı maddi ve manevi zararların tazminini talep edebilir. (TKHK md. 11)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Malın ayıplı olduğu teslimden sonraki 6 ay içinde ortaya çıkarsa, malın teslim tarihinde var olduğu kabul edilir (ispat yükünün yer değiştirmesi). (TKHK md. 10)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, taksitle satış sözleşmelerinde de 7 gün içinde cayma hakkına sahiptir. (TKHK md. 17)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketiciler, Tüketici Sorunları Hakem Heyeti veya Tüketici Mahkemelerine başvurmadan önce arabulucuya gitmek zorundadır (belirlenen parasal sınırların üzerindeki davalar için). (TKHK md. 73/A)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Devre tatil sözleşmelerinde ön ödeme yapılamaz; ön ödeme yasağı vardır. (TKHK md. 50)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Satıcı, ayıbın gizlenmesinde ağır kusurlu ise, iki yıllık zamanaşımı süresinden sorumlu tutulamaz. (TKHK md. 12)"
    },
    {
      "title": "Tüketicinin Korunması Hakkında Kanun (Seçmeler)",
      "body": "Tüketici, kapıdan satışlarda elden teslim edilen malların iade masrafından sorumlu tutulamaz. (TKHK md. 47)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşçi, iş sözleşmesinin kanuna aykırı sona erdirilmesi durumunda işe iade davası açabilir. (İş Kanunu md. 20)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İş sözleşmesi feshedilen işçi, feshin geçersizliği iddiasıyla arabulucuya başvurmak zorundadır. (İş Kanunu md. 20)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşçi, haklı nedenle iş sözleşmesini derhal feshedebilir ve kıdem tazminatına hak kazanır. (İş Kanunu md. 24)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşçinin en az bir yıl çalışması varsa, iş sözleşmesinin feshi halinde kıdem tazminatına hak kazanır. (İş Kanunu md. 14)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşveren, işçiyi işten çıkarırken işçiye bildirim sürelerine uymak zorundadır. (İş Kanunu md. 17)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşveren, bildirim sürelerine uymaksızın işçiyi işten çıkarırsa, ihbar tazminatı ödemek zorundadır. (İş Kanunu md. 17)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşçi, yıllık ücretli izin hakkını kullanmak zorundadır. (İş Kanunu md. 53)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşçinin haftalık çalışma süresi kural olarak en çok 45 saattir. (İş Kanunu md. 63)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "Fazla çalışma (haftalık 45 saati aşan çalışma) ücreti, normal ücretin %50 fazlasıyla ödenir. (İş Kanunu md. 41)"
    },
    {
      "title": "İş Kanunu (Seçmeler)",
      "body": "İşveren, engelli ve eski hükümlü çalıştırma zorunluluğuna uymak zorundadır. (İş Kanunu md. 30)"
    }
  ];

  // init
  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // Android ayarları
    const initSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");

    // iOS ayarları
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings =
    InitializationSettings(android: initSettingsAndroid, iOS: initSettingsIOS);

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;

    // Günlük bildirimi kur
    await scheduleDailyNotification();
  }

  // notification details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        icon: "@drawable/notification_icon",
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // Anlık notification (test amaçlı)
  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(id, title, body, notificationDetails());
  }

  // Günün mesajını belirle
  Map<String, String> getTodaysMessage() {
    final today = DateTime.now();
    final seed = today.year + today.month + today.day;

    final random = Random(seed);
    return messages[random.nextInt(messages.length)];
  }

  // Her gün 17:58'de random mesaj schedule et
  Future<void> scheduleDailyNotification() async {
    final msg = getTodaysMessage();
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      14,
      42,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await notificationsPlugin.zonedSchedule(
      1,
      msg["title"],
      msg["body"],
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // günlük tekrar

    );
  }
}
