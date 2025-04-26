---
layout: default
permalink: /latest/
title: Our Latest Review
---

{% assign latest = site.posts | first %}

{% include site-header.html %}

<main class="main  container">
  {% include post-wrapper.html post=latest %}
</main>

{% include site-footer.html %}