'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.ico": "725ff730e94c8e783fb6e48fc286be8a",
"firebase-messaging-sw.js": "88e93fccc2a2be27dc730004f895aea2",
"icons/Icon-512-maskable.png": "d61dbd9c1c443a8039cd240b56aa60f6",
"icons/Icon-192.png": "20496b61137bf05bbfcb97af890451ef",
"icons/Icon-192-maskable.png": "b192b3b1053778ac1be389f851c4f3e6",
"icons/Icon-512.png": "43c7e1aeb595005726c48822bef89fad",
"privacy.html": "cc6078323d7d57df359c5d13c81b4bdd",
"assets/fonts/MaterialIcons-Regular.otf": "06b18130a76c4516c324d266b9236fb6",
"assets/AssetManifest.bin.json": "1122bad53725d48146c71a524433adbc",
"assets/AssetManifest.bin": "a7850aca6d3a8b3519f30653ef7b26a4",
"assets/AssetManifest.json": "0f5b3a4d88ae8233991dcf11ae903c61",
"assets/assets/fonts/FjallaOne-Regular.ttf": "ec1b2f280f4da66724d41ecd5275ef27",
"assets/assets/fonts/museo-sans/MuseoSans-100Italic.otf": "215d4717c588e9be9cc7a88a874242e6",
"assets/assets/fonts/museo-sans/MuseoSans-700Italic.otf": "bfaffeb345080c0301f1b3c9484e81f4",
"assets/assets/fonts/museo-sans/MuseoSans-500Italic.otf": "2ed19ea209faf95c15ab1def268dfbe3",
"assets/assets/fonts/museo-sans/MuseoSans-700.otf": "10aaa353d22c131091d217c83f558343",
"assets/assets/fonts/museo-sans/MuseoSans-300.otf": "bdb59b808cfc4fb88f3963fa06e6c79b",
"assets/assets/fonts/museo-sans/MuseoSans-500.otf": "62c0135163427c652ae397f327f85010",
"assets/assets/fonts/museo-sans/MuseoSans-900Italic.otf": "b38bb864578a8cb1f560f74c575431cf",
"assets/assets/fonts/museo-sans/MuseoSans-900.otf": "f5d070fca3ddc0fce188de14f62bf795",
"assets/assets/fonts/museo-sans/MuseoSans-300Italic.otf": "9b34d69f3945fa1e308c84fd3a4cb37f",
"assets/assets/fonts/museo-sans/MuseoSans-100.otf": "f685618a57314edf0b910a2a8a572cd7",
"assets/assets/fonts/icon_home/Home2.ttf": "9f791d2051c0ef7d7c9e5a58ff6cb7dd",
"assets/assets/fonts/icon_home/Home.ttf": "fcc64c7f181c9639c4a1607be318c169",
"assets/assets/images/main-logo-azul.png": "1e1948fafd8c202bf68c6d413c1dafc6",
"assets/assets/images/home_activity_13.webp": "74ace63aefc0e3358e20c098308cb11c",
"assets/assets/images/home_activity_7.webp": "1da33bf2967c5d2450c21d74d62cbe10",
"assets/assets/images/guests_17.webp": "3262dcbff2b74290a2b7cbaa61a5579b",
"assets/assets/images/home_sessions.jpg": "5023f79c39727133bd62d1ef1190a449",
"assets/assets/images/activity_card_a3.jpg": "72147c936e9d0e14e878f84f556d596c",
"assets/assets/images/activity_card_a1.jpg": "411325cbb2779dc3905951d3447be012",
"assets/assets/images/activity_image_1.webp": "f679677e544b2719d2dfa314f42971f5",
"assets/assets/images/home_activity_9.webp": "3daafc053fa04034e078ae5a0657f49c",
"assets/assets/images/guests_2.webp": "c31cdaa4349533689d3cf4490369745b",
"assets/assets/images/logo_mrnt.webp": "79946278bd52d299f6b1acc8d452ded2",
"assets/assets/images/maps/map_3_thumbnail.webp": "15028b95e80c808e85273d41eef9c30c",
"assets/assets/images/maps/map_3.webp": "82b9970b9b195a03ecb85cc1cc8649d9",
"assets/assets/images/home_qr.webp": "66ab016bb3d3a628c16c37cee7af4f14",
"assets/assets/images/home_activity_10.webp": "12033a934944d3c885c618fe19532001",
"assets/assets/images/guests_16.webp": "5bc465f74b7e570cd98208986411e159",
"assets/assets/images/guests_4.webp": "7631c23e9a0d6cb356ae77c5ae2e784a",
"assets/assets/images/home_tourism.jpg": "e1436cd3ee75820e41b84656c22d862e",
"assets/assets/images/home_activity_2.webp": "9238213083e20621f114bebaeaab42ac",
"assets/assets/images/guests_5.webp": "a6d4c1b3ee3dbb7c29f9079a31feeb90",
"assets/assets/images/activity_image_4.webp": "02eea9d81a87dedc3c3325b0711a8cf3",
"assets/assets/images/logo_worship.png": "4e89c4fa477e857f728844baf9baf0ce",
"assets/assets/images/guests_11.webp": "e77781cb7284f485bf17a1a7b1a92a25",
"assets/assets/images/guests_3.webp": "8f14727d74891b74803d60e03bd236fa",
"assets/assets/images/home_activity_1.webp": "83b49e29e62437d0238f9556d3e2a0aa",
"assets/assets/images/home_activity_5.webp": "6ca54fa72a5c694461739ba0de555713",
"assets/assets/images/home_bulletin.webp": "6e622e427f3f62bd407b22ac0c4249e2",
"assets/assets/images/activity_image_3.webp": "c32ef68301131a04c7d02f312d60cd74",
"assets/assets/images/guests_6.webp": "5d5d04d8362bccfc16064304bac1aea7",
"assets/assets/images/home_activity_8.webp": "a4638b9c7729d480799f5b4a5de96374",
"assets/assets/images/home_main_objectives.webp": "1099836826281d87be482b9969abdc98",
"assets/assets/images/activity_image_2.webp": "5d11b0cd94a4e1b6d4b1e62f9ebe94b2",
"assets/assets/images/home_activity_12.webp": "4c2558e126f42ace2e207d43806db85d",
"assets/assets/images/activity_card_a5.jpg": "ab0da9df903dc8d78da7e164b1665ca0",
"assets/assets/images/guests_15.webp": "8d84624ad23826d83dfc88c4c7a20066",
"assets/assets/images/activity_card_a2.png": "a80cc4a65cc1a99dc585e4a15e65060e",
"assets/assets/images/guests_8.webp": "ca13bd96243417b93647a8f2d75dc123",
"assets/assets/images/login_background2.webp": "25b97fbb7243fcb360df1967bbba7817",
"assets/assets/images/home_activity_11.webp": "04c010acaad8c64926f37de3f7920a9d",
"assets/assets/images/guests_1.webp": "5ec0a99c78d5e4d29dc46edefb47f01a",
"assets/assets/images/main_drawer_background.png": "4f32db84e08c535fea232b84be6b700d",
"assets/assets/images/guests_13.webp": "2b36811d441033af977278751eab92e9",
"assets/assets/images/home_activity_14.webp": "86bbd5fde98a7c065913899c5c127aa5",
"assets/assets/images/bulletin_1.webp": "6263007edc744290da644257f9c3a02c",
"assets/assets/images/home_activity_6.webp": "2c429a0dfd69b646beea0414be65c39f",
"assets/assets/images/guests_10.webp": "ff21a63f5edd7455e65db9c07f9e698e",
"assets/assets/images/guest_card_1.webp": "ee32f84e3aefb3432ddbe084807be80a",
"assets/assets/images/guests_14.webp": "3d83083818009e3da93f340cc3354513",
"assets/assets/images/guests_12.webp": "7f90f64fab981c65e8206790c8e694d5",
"assets/assets/images/home_stands.webp": "04dcd1cf441488fa33a8234d5ed099ff",
"assets/assets/images/home_workshops.webp": "b9e362d683efa4eebca1e072e8130b64",
"assets/assets/images/main_logo_white.png": "8d7cf5feacd00b3e68cc5f2d617ee171",
"assets/assets/images/home_activity_3.webp": "eb22aa1a44ede9a1ec82d9e6e2e7df55",
"assets/assets/images/main_logo_apce_5.webp": "332722b381bb5a9a1396113bf4bc10c6",
"assets/assets/images/home_guests.webp": "ee32f84e3aefb3432ddbe084807be80a",
"assets/assets/images/guide_card_1.webp": "e95b793d5b850497f8907fc3e06f99e3",
"assets/assets/images/guests_7.webp": "49d5135d3c4fe63aab5cc8801a16ff10",
"assets/assets/images/guests_9.webp": "20db7cb807afd23cb03e6d13465c7d89",
"assets/assets/images/home_activity_4.webp": "aae4b358a3e3db21be10634ed4ad6879",
"assets/assets/images/activity_card_a4.jpg": "b2a9072e6a919e3ff1a0c9e7c1433896",
"assets/assets/lottie/qr_scan.json": "55ee442baf76227cafa3f6c489920ddb",
"assets/assets/lottie/check_3.json": "8a7e425cdb6fd198f681fb852f24425d",
"assets/assets/lottie/lock.json": "6bf731698e11631cf4d40a27e4c94152",
"assets/assets/lottie/info.json": "183ddc9eb3fecf480926d243d333ef9f",
"assets/assets/lottie/loading.json": "0104951b64863a36170242fd6c055e3c",
"assets/assets/lottie/check.json": "3b26f9c20622d3804047f7b629f07423",
"assets/assets/lottie/check_2.json": "14a616d7193c55d692b68babae271929",
"assets/assets/lottie/check_out.json": "c2dbe2e3742b49e525a6b615a79572b1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/FontManifest.json": "1d51b1c42a08e109c5e0e8ca059c223f",
"assets/NOTICES": "282e47114eb32f483b348bba448f53c1",
"main.dart.js": "ee679aa9cf7db8780c070ee1e0552f56",
"manifest.json": "318fccef307109f0d3167bf99df85585",
"version.json": "c4f8a55b97458b94a362c1504527661d",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"images/logo.jpg": "95f196f91e6b822c4b6d1553845dc2f2",
"flutter_bootstrap.js": "07000bd2d63c20b6814ed4c11b43aa9d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "254040483db548643756c48ce5370bfa",
"/": "254040483db548643756c48ce5370bfa",
"flutter.js": "76f08d47ff9f5715220992f993002504"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
