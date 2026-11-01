module.exports = {
  lang: "en-GB",
  title: "BAATFR",
  description: "Restaurant reviews",
  url: "https://www.businessandyandthefeerex.co.nz",
  logo: "/assets/logos/logo.png",
  manifestThemeColor: "#242e2b",
  navigationHeader: [
    { title: "Home", url: "/" },
    { title: "Reviews", url: "/reviews/" },
    { title: "Browse by Region", url: "/regions/" },
    { title: "Browse the Map", url: "/map/" },
    { title: "Search", url: "/search/" },
    { title: "Subscribe", url: "/subscribe/" },
  ],
  fonts: {
    preconnectUrls: ["https://fonts.gstatic.com"],
    fontUrls: [
      "https://fonts.googleapis.com/css2?family=Merriweather:wght@400;700&display=swap",
    ],
  },
  favicons: [
    { size: 16, path: "/assets/logos/logo@16px.png" },
    { size: 32, path: "/assets/logos/logo@32px.png" },
    { size: 96, path: "/assets/logos/logo@96px.png" },
    { size: 120, path: "/assets/logos/logo@120px.png" },
    { size: 144, path: "/assets/logos/logo@144px.png" },
    { size: 180, path: "/assets/logos/logo@180px.png" },
    { size: 512, path: "/assets/logos/logo@512px.png" },
    { size: 1024, path: "/assets/logos/logo@1024px.png" },
  ],
};
