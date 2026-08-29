---
layout: page
title: Margaret River, Margaret River, Western Australia, Australia
country: Australia
region: Western Australia
suburb: Margaret River
city: Margaret River
permalink: /country/australia/western-australia/margaret-river/margaret-river/
---
[↑ Go to Margaret River](/country/australia/western-australia/margaret-river/)

{% assign posts = site.posts | where: "country", "Australia" | where: "region", "Western Australia" | where: "suburb", "Margaret River" | where: "city", "Margaret River" %}
{% assign grouped_posts = posts | group_by: "rating" %}
{% assign sorted_grouped_posts = grouped_posts | sort: "name" %}

{% for group in sorted_grouped_posts reversed %}
  <h4>Rating: {{ group.name }}</h4>
  <ul>
    {% for post in group.items %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %}
