const version = '20260829054856';
const cacheName = `static::${version}`;

const buildContentBlob = () => {
  return ["/reviews/2026/08/28/salty-pidgin/","/reviews/2026/08/23/highway-57-bakery-and-cafe/","/reviews/2026/08/22/east-pier-hotel/","/reviews/2026/08/21/afghan-darbar-restaurant-and-takeaway/","/reviews/2026/08/15/the-realm-hataitai/","/reviews/2026/08/14/the-original-thai-restaurant/","/reviews/2026/08/08/simmer-cafe/","/reviews/2026/08/07/1852-pub-and-kitchen/","/reviews/2026/08/01/the-botanist/","/reviews/2026/07/31/highwater-eatery/","/blog/","/collections/","/","/latest/","/manifest.json","/map/","/offline/","/regions/","/assets/search.json","/search/","/assets/styles.css","/subscribe/","/thanks/","/redirects.json","/sitemap.xml","/robots.txt","/feed.xml","/assets/styles.css.map","/assets/logos/logo.png", "/assets/default-offline-image.png", "/assets/scripts/fetch.js"
  ]
}

const updateStaticCache = () => {
  return caches.open(cacheName).then(cache => {
    return cache.addAll(buildContentBlob());
  });
};

const clearOldCache = () => {
  return caches.keys().then(keys => {
    // Remove caches whose name is no longer valid.
    return Promise.all(
      keys
        .filter(key => {
          return key !== cacheName;
        })
        .map(key => {
          console.log(`Service Worker: removing cache ${key}`);
          return caches.delete(key);
        })
    );
  });
};

self.addEventListener("install", event => {
  event.waitUntil(
    updateStaticCache().then(() => {
      console.log(`Service Worker: cache updated to version: ${cacheName}`);
    })
  );
});

self.addEventListener("activate", event => {
  event.waitUntil(clearOldCache());
});

self.addEventListener("fetch", event => {
  let request = event.request;
  let url = new URL(request.url);

  // Only deal with requests from the same domain.
  if (url.origin !== location.origin) {
    return;
  }

  // Always fetch non-GET requests from the network.
  if (request.method !== "GET") {
    event.respondWith(fetch(request));
    return;
  }

  // Default url returned if page isn't cached
  let offlineAsset = "/offline/";

  if (request.url.match(/\.(jpe?g|png|gif|svg)$/)) {
    // If url requested is an image and isn't cached, return default offline image
    offlineAsset = "/assets/default-offline-image.png";
  }

  // For all urls request image from network, then fallback to cache, then fallback to offline page
  event.respondWith(
    fetch(request).catch(async () => {
      return (await caches.match(request)) || caches.match(offlineAsset);
    })
  );
  return;
});
