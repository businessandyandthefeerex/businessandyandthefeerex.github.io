const version = '20250501043522';
const cacheName = `static::${version}`;

const buildContentBlob = () => {
  return ["/reviews/2025/04/24/Kaimak/","/reviews/2025/02/20/Clearview-Estate/","/reviews/2025/02/07/Crack-Chicken/","/reviews/2024/11/08/A1-Takeaways-Hong-Kong-Style-BBQ/","/reviews/2024/10/26/Tongariro-Lodge/","/reviews/2024/10/26/Suncourt-Indian/","/reviews/2024/10/25/Golden-Crust-Pizza/","/reviews/2024/08/10/Mr-Glen's-Taphouse-&-Tapas/","/reviews/2024/08/09/The-Dining-Room-at-The-Headwaters-Eco-Lo/","/reviews/2024/07/26/Exhale-Exmouth/","/blog/","/collections/","/","/latest/","/manifest.json","/map/","/offline/","/regions/","/assets/search.json","/search/","/assets/styles.css","/subscribe/","/thanks/","/redirects.json","/feed.xml","/sitemap.xml","/robots.txt","/assets/styles.css.map","/assets/logos/logo.png", "/assets/default-offline-image.png", "/assets/scripts/fetch.js"
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
