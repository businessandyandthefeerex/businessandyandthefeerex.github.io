const version = '20250419120135';
const cacheName = `static::${version}`;

const buildContentBlob = () => {
  return ["/reviews/2024/11/08/A1-Takeaways-Hong-Kong-Style-BBQ/","/reviews/2024/11/03/The-Rusty-Bros/","/reviews/2024/11/02/Urban-Gusto/","/reviews/2024/02/22/Stratosfare-Restaurant-&-Bar/","/reviews/2023/12/08/Zane-Grey's-Restaurant-&-Bar/","/reviews/2023/12/08/Madly-Indian/","/reviews/2023/12/08/hello-world/","/general/2016/08/29/example-post-three/","/history/external%20sources/2016/08/28/example-post-two/","/general/external%20sources/2016/08/27/example-post-one/","/about/","/country/new-zealand/bay-of-plenty/","/categories/","/country/","/elements/","/blog/","/country/new-zealand/","/","/country/australia/","/manifest.json","/map/","/country/new-zealand/northland/","/offline/","/region/","/reviews/","/assets/search.json","/search/","/assets/styles.css","/country/australia/test-region/","/thanks/","/country/new-zealand/wellington/","/redirects.json","/blog/page2/","/blog/page3/","/blog/page4/","/blog/page5/","/feed.xml","/sitemap.xml","/robots.txt","/assets/styles.css.map","/assets/logos/logo.svg", "/assets/default-offline-image.png", "/assets/scripts/fetch.js"
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
