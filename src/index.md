---
layout: page.njk
title: Business Andy & The Fee-Rex
---

# Restaurant Reviews

<img id="featured-image" src="" alt="Featured image">

## The Restaurant Rating System

4 - Great  
3 - Good  
2 - Meh  
1 - Bad

## The Restaurant Selection System

Restaurants are usually selected either using a random number generator or on an eat-at-the-first-place-we-see basis.

<script>
  const images = [
    "/assets/images/page_art_01.png",
    "/assets/images/page_art_02.png",
    "/assets/images/page_art_03.png"
  ];

  const featuredImage = document.getElementById("featured-image");
  featuredImage.src = images[Math.floor(Math.random() * images.length)];
</script>
