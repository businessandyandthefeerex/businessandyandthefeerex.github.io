const version = '20250421133622';
const cacheName = `static::${version}`;

const buildContentBlob = () => {
  return ["/reviews/2024/11/08/A1-Takeaways-Hong-Kong-Style-BBQ/","/reviews/2024/11/03/The-Rusty-Bros/","/reviews/2024/11/02/Urban-Gusto/","/reviews/2024/07/19/Ayhan-s-Turkish-Cafe/","/reviews/2024/03/20/Autobahn-Cafe/","/reviews/2024/02/22/Stratosfare-Restaurant-&-Bar/","/reviews/2023/12/08/Zane-Grey's-Restaurant-&-Bar/","/reviews/2023/12/08/Madly-Indian/","/posts_to_transition/Baked%20With%20Love%20Cafe%20&%20Cakery/","/posts_to_transition/Bambina%20Pizzeria/","/posts_to_transition/Bay%20of%20Many%20Coves/","/posts_to_transition/Better%20Choice%20Cafe/","/posts_to_transition/Botswana%20Butchery/","/posts_to_transition/Braaihut/","/posts_to_transition/Cafe%20Huhu/","/posts_to_transition/Captain%20Andy's%20Beach%20Bar%20&%20Grill/","/posts_to_transition/Catlins%20Inn/","/posts_to_transition/Clearview%20Estate/","/posts_to_transition/Coffee%20Culture/","/posts_to_transition/Crack%20Chicken/","/posts_to_transition/Creel%20Tackle%20House%20&%20Cafe/","/posts_to_transition/Curry%20Guru%20The%20Malabar%20Kitchen/","/posts_to_transition/Der%20Metz/","/posts_to_transition/Dunedin%20Social%20Club/","/posts_to_transition/Embers%20Woodfired%20Pizza%20Restaurant/","/posts_to_transition/Exhale%20Exmouth/","/posts_to_transition/Federal%20Delicatessen/","/posts_to_transition/Floating%20Rock%20Cafe/","/posts_to_transition/Golden%20Crust%20Pizza/","/posts_to_transition/Golden%20Dragon%20Chinese%20Restaurant/","/posts_to_transition/Hare%20&%20Copper%20Eatery/","/posts_to_transition/Hayz%20at%20the%20Anchorage/","/posts_to_transition/Homestead%20Brewery/","/posts_to_transition/Hotties%20Beachfront%20Eatery/","/posts_to_transition/Hydro%20Eatery/","/posts_to_transition/Jumpstart%20Cafe/","/posts_to_transition/Kai%20&%20Co/","/posts_to_transition/Kai%20Whakapai/","/posts_to_transition/Kika/","/posts_to_transition/Latitude%2037/","/posts_to_transition/Licorice%20Cafe/","/posts_to_transition/Little%20Blue%20Kitchen/","/posts_to_transition/Little%20Polynesian%20Resort/","/posts_to_transition/London%20Quay%20Cafe/","/posts_to_transition/Manapouri%20Cafe%20&%20Dairy/","/posts_to_transition/Miss%20Lucy's/","/posts_to_transition/Mission%20Estate%20Winery/","/posts_to_transition/Mr%20Glen's%20Taphouse%20&%20Tapas/","/posts_to_transition/NZ%20Kebab%20&%20Pizza%20House/","/posts_to_transition/Nanny's%20Eatery/","/posts_to_transition/New%20York%20Grill/","/posts_to_transition/Oakover%20Grounds/","/posts_to_transition/Oreti%20Restaurant/","/posts_to_transition/Pauly's%20Diner/","/posts_to_transition/Pembroke%20Patisserie/","/posts_to_transition/Pinch%20of%20Spice/","/posts_to_transition/Playlab%20Cafe/","/posts_to_transition/Pukenui%20Pacific%20Restaurant%20&%20Bar/","/posts_to_transition/Red%20Rooster/","/posts_to_transition/Reflections/","/posts_to_transition/Riverside%20Bar%20&%20Restaurant/","/posts_to_transition/Riverstone%20Kitchen/","/posts_to_transition/Rothko/","/posts_to_transition/Rust%20Licensed%20Gourmet%20Burger%20Bar/","/posts_to_transition/Sal's%20Authentic%20New%20York%20Pizza/","/posts_to_transition/Salt%20Bar%20&%20Restaurant/","/posts_to_transition/Sidekick%20Cafe/","/posts_to_transition/Sons%20of%20Naples/","/posts_to_transition/Soul%20Bar%20&%20Bistro/","/posts_to_transition/South%20Sea%20Hotel/","/posts_to_transition/Suncourt%20Indian/","/posts_to_transition/Taco%20Loco%20Cantina/","/posts_to_transition/Tarras%20Country%20Cafe/","/posts_to_transition/The%20BBQ%20Father%20&%20Deli/","/posts_to_transition/The%20Black%20Dog%20Kitchen%20&%20Bar/","/posts_to_transition/The%20Cheese%20Barn%20at%20Matatoki/","/posts_to_transition/The%20Coffee%20Club/","/posts_to_transition/The%20Courthouse%20Cafe/","/posts_to_transition/The%20Dining%20Room%20at%20The%20Headwaters%20Eco%20Lo/","/posts_to_transition/The%20Gipsy%20Moth/","/posts_to_transition/The%20Plaza/","/posts_to_transition/The%20Quay%20Cafe/","/posts_to_transition/The%20River/","/posts_to_transition/The%20Spice%20Room/","/posts_to_transition/The%20Vessel/","/posts_to_transition/Toastie%20Picton/","/posts_to_transition/Tongariro%20Lodge/","/posts_to_transition/Turangi%20Bridge%20Motel,%20Bar%20&%20Restaurant/","/posts_to_transition/Turangi%20Tavern/","/posts_to_transition/Vaima%20Restaurant%20&%20Bar/","/posts_to_transition/Valentines/","/posts_to_transition/Valentino's/","/posts_to_transition/Wairakei%20Resort%20Taupo/","/posts_to_transition/Wallingford%20Homestead/","/posts_to_transition/Wildflower/","/about/","/browse-region/","/posts_to_transition/businessandyandthe/","/elements/","/blog/","/","/manifest.json","/browse-map/","/offline/","/assets/search.json","/search/","/assets/styles.css","/thanks/","/redirects.json","/blog/page2/","/blog/page3/","/blog/page4/","/feed.xml","/sitemap.xml","/robots.txt","/assets/styles.css.map","/assets/logos/logo.svg", "/assets/default-offline-image.png", "/assets/scripts/fetch.js"
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
