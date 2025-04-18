---
title: Reviews by Region
permalink: /region/
---
All our restaurant reviews listed by region.

<h1>Regions</h1>
<ul>
  {% assign posts = site.categories.reviews %}
  {% assign regions = posts | map: 'region' | uniq | sort %}
  {% for region in regions %}
    <li><a href="/region/{{ region | downcase | replace: ' ', '-' }}/">{{ region }}</a></li>
  {% endfor %}
</ul>