import '../models/campus_item.dart';

List<CampusItem> getMockData() {
  return [
    // ── Dersler ──
    CampusItem(
      id: 'c1',
      category: Category.COURSE,
      title: 'Algoritma ve Veri Yapıları',
      description:
          'Bu derste temel ve ileri düzey algoritmaları öğreneceksiniz. Sıralama algoritmaları (QuickSort, MergeSort, HeapSort), arama algoritmaları (Binary Search, BFS, DFS) ve veri yapıları (bağlı listeler, yığınlar, kuyruklar, ağaçlar, graflar ve hash tabloları) üzerinde çalışılır. Her hafta teorik ders ve ardından uygulamalı laboratuvar çalışması yapılmaktadır. Dönem sonu projesi olarak gerçek bir problem üzerinde algoritma tasarımı beklenmektedir.',
      date: '2026-02-17',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'c2',
      category: Category.COURSE,
      title: 'İlişkisel Veritabanları',
      description:
          'Veritabanı yönetim sistemlerinin temellerinden ileri düzey konulara kadar kapsamlı bir eğitim sunulur. E/R diyagramları ile kavramsal tasarım, ilişkisel şema dönüşümü, normalizasyon (1NF, 2NF, 3NF, BCNF), SQL sorguları (JOIN, Subquery, View, Trigger, Stored Procedure) ve işlem yönetimi (Transaction, ACID) konuları işlenir. PostgreSQL veritabanı üzerinde uygulamalı proje çalışması yapılmaktadır.',
      date: '2026-02-18',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 'c3',
      category: Category.COURSE,
      title: 'Mobil Uygulama Geliştirme',
      description:
          'Flutter framework ve Dart programlama dili kullanılarak cross-platform mobil uygulama geliştirme dersidir. Widget yapısı, state yönetimi (setState, Provider), navigasyon, HTTP istekleri, yerel depolama ve kullanıcı arayüzü tasarımı konuları detaylı şekilde işlenir. Material Design prensipleri uygulanarak modern ve profesyonel uygulamalar oluşturulmaktadır. Dönem boyunca bireysel bir mobil proje geliştirilir.',
      date: '2026-02-19',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'c4',
      category: Category.COURSE,
      title: 'Bilgisayar Ağları',
      description:
          'OSI referans modeli ve TCP/IP protokol yığını detaylı olarak incelenir. Fiziksel katmandan uygulama katmanına kadar her katmanın protokolleri (Ethernet, IP, TCP, UDP, HTTP, DNS, DHCP) ele alınmaktadır. Yönlendirme algoritmaları, alt ağ bölme (subnetting), NAT, güvenlik duvarı ve VPN konuları işlenir. Cisco Packet Tracer simülatörü ile ağ topolojileri tasarlanır ve test edilir.',
      date: '2026-02-20',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 'c5',
      category: Category.COURSE,
      title: 'Nesne Yönelimli Programlama',
      description:
          'Java programlama dili kullanılarak nesne yönelimli programlama (OOP) prensipleri öğretilir. Sınıflar, nesneler, kalıtım (inheritance), çok biçimlilik (polymorphism), soyutlama (abstraction) ve kapsülleme (encapsulation) kavramları detaylı olarak işlenir. Tasarım kalıpları (Singleton, Factory, Observer) tanıtılır. UML diyagramları ile yazılım tasarımı yapılır ve dönem boyunca takım projesi geliştirilir.',
      date: '2026-02-21',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'c6',
      category: Category.COURSE,
      title: 'İşletim Sistemleri',
      description:
          'Modern işletim sistemlerinin yapısı ve temel kavramları incelenir. Süreç yönetimi (process scheduling), iş parçacıkları (threads), eşzamanlılık (concurrency), bellek yönetimi (paging, segmentation), dosya sistemleri ve giriş/çıkış yönetimi konuları teorik ve pratik olarak ele alınır. Linux ortamında shell scripting ve sistem programlama uygulamaları yapılmaktadır.',
      date: '2026-02-22',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 'c7',
      category: Category.COURSE,
      title: 'Yapay Zeka ve Makine Öğrenmesi',
      description:
          'Yapay zekanın temel kavramları, arama algoritmaları, bilgi gösterimi ve makine öğrenmesi teknikleri öğretilir. Denetimli öğrenme (regresyon, sınıflandırma), denetimsiz öğrenme (kümeleme, boyut indirgeme) ve derin öğrenme (sinir ağları, CNN, RNN) konuları Python ile uygulamalı olarak işlenir. TensorFlow ve scikit-learn kütüphaneleri kullanılarak gerçek veri setleri üzerinde projeler geliştirilir.',
      date: '2026-02-24',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'c8',
      category: Category.COURSE,
      title: 'Web Programlama',
      description:
          'Full-stack web geliştirme dersidir. Frontend tarafında HTML5, CSS3, JavaScript ve React.js; backend tarafında Node.js ve Express.js kullanılır. RESTful API tasarımı, veritabanı entegrasyonu, kullanıcı kimlik doğrulama (JWT), responsive tasarım ve deployment konuları detaylı şekilde işlenir. Dönem sonunda tam işlevsel bir web uygulaması projesi teslim edilir.',
      date: '2026-02-25',
      priority: Priority.NORMAL,
    ),

    // ── Ödevler ──
    CampusItem(
      id: 't1',
      category: Category.TASK,
      title: 'Algoritma Ödevi — Hızlı Sıralama',
      description:
          'Python programlama dili kullanarak QuickSort algoritmasını sıfırdan uygulayın. Pivot seçim stratejilerini (ilk eleman, son eleman, medyan) karşılaştırın. En iyi, ortalama ve en kötü durum zaman karmaşıklıklarını Big-O notasyonu ile analiz edin. MergeSort ile performans karşılaştırması yaparak grafik oluşturun. Rapor, kaynak kodu ve test sonuçları ile birlikte teslim edin.',
      date: '2026-02-22',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 't2',
      category: Category.TASK,
      title: 'Veritabanı Tasarım Raporu',
      description:
          'Seçilen proje konusu için kapsamlı bir veritabanı tasarım raporu hazırlayın. Raporda E/R diyagramı, ilişkisel şema dönüşümü, normalizasyon adımları (1NF\'den BCNF\'ye), en az 15 farklı SQL sorgusu (basit ve karmaşık JOIN\'ler, alt sorgular, aggregate fonksiyonlar), veri sözlüğü ve indeksleme stratejileri yer almalıdır. PostgreSQL üzerinde çalışan bir demo sunumu hazırlayın.',
      date: '2026-02-25',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 't3',
      category: Category.TASK,
      title: 'Flutter Mini Proje',
      description:
          'Flutter framework kullanarak basit ama işlevsel bir görev yönetim uygulaması oluşturun. Uygulama en az 3 ekrandan oluşmalıdır (liste, detay, ekleme formu). Material Design bileşenlerini kullanın, ekranlar arası Navigator ile geçiş yapın. State yönetimi için setState veya Provider kullanabilirsiniz. Uygulamada arama, filtreleme ve yerel veri saklama özellikleri beklenmektedir.',
      date: '2026-03-01',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 't4',
      category: Category.TASK,
      title: 'Ağ Alıştırmaları — Alt Ağ Bölme',
      description:
          'Verilen 10 alıştırmayı çözün. Her alıştırmada IP adresi ve CIDR notasyonundan yola çıkarak ağ adresini, yayın adresini, kullanılabilir IP aralığını ve alt ağ maskesini hesaplayın. VLSM (Variable Length Subnet Masking) ile farklı boyutlarda alt ağlar oluşturun. Çözümlerinizi adım adım gösterin ve Cisco Packet Tracer ile doğrulayın.',
      date: '2026-02-28',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 't5',
      category: Category.TASK,
      title: 'OOP Proje — Kütüphane Yönetim Sistemi',
      description:
          'Java ile nesne yönelimli programlama prensiplerini kullanarak bir kütüphane yönetim sistemi geliştirin. Kitap, üye, ödünç alma ve iade işlemlerini modelleyin. Kalıtım, arayüzler (interface) ve exception handling kullanın. UML sınıf diyagramı çizin ve JUnit ile birim testleri yazın. Proje GitHub üzerinden teslim edilecektir.',
      date: '2026-03-05',
      priority: Priority.IMPORTANT,
    ),

    // ── Etkinlikler ──
    CampusItem(
      id: 'e1',
      category: Category.EVENT,
      title: 'Üniversite Hackathon',
      description:
          'Üniversitemizin düzenlediği 48 saatlik yazılım geliştirme yarışmasına katılın! Bu yılın teması "Eğitim İçin Teknoloji". Takımlar en fazla 4 kişiden oluşabilir. Katılımcılara mentörlük desteği, yemek ve içecek sağlanacaktır. Kazanan takıma 10.000 TL ödül ve staj imkanı sunulacaktır. Son kayıt tarihi: 20 Şubat. Başvuru formu üniversite web sitesinde mevcuttur.',
      date: '2026-03-05',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'e2',
      category: Category.EVENT,
      title: 'Yapay Zeka Konferansı',
      description:
          'Prof. Dr. Yılmaz tarafından "Derin Öğrenmenin Geleceği ve Sağlık Alanındaki Uygulamaları" konulu konferans düzenlenecektir. Konferansta güncel araştırma sonuçları, ChatGPT ve büyük dil modelleri, tıbbi görüntü analizi ve yapay zeka etiği konuları ele alınacaktır. Ana amfi salonu, saat 14:00-16:00. Katılım ücretsizdir ancak ön kayıt gereklidir.',
      date: '2026-02-26',
      priority: Priority.NORMAL,
    ),
    CampusItem(
      id: 'e3',
      category: Category.EVENT,
      title: 'Staj ve Kariyer Fuarı',
      description:
          'Türkiye\'nin önde gelen teknoloji şirketleriyle buluşma fırsatı! 50\'den fazla şirket standlarıyla katılacaktır. Özgeçmişinizi ve portfolyonuzu getirmeniz önerilir. Birebir mülakat imkanı, CV değerlendirme atölyesi ve kariyer danışmanlığı hizmetleri sunulacaktır. Merkez hol ve konferans salonu, 09:00-17:00 arası. Tüm bölüm öğrencilerine açıktır.',
      date: '2026-03-10',
      priority: Priority.IMPORTANT,
    ),
    CampusItem(
      id: 'e4',
      category: Category.EVENT,
      title: 'Açık Kapı Günü',
      description:
          'Lise son sınıf öğrencilerine yönelik tanıtım günü düzenlenmektedir. Bilgisayar Mühendisliği, Yazılım Mühendisliği ve Bilgi Teknolojileri bölümleri tanıtılacaktır. Öğrenci projeleri sergilenecek, laboratuvar turları yapılacak ve mevcut öğrencilerle soru-cevap oturumları düzenlenecektir. Bilgisayar standında gönüllü olarak görev almak isteyen öğrenciler bölüm sekreterliğine başvurabilir.',
      date: '2026-03-15',
      priority: Priority.NORMAL,
    ),
  ];
}
