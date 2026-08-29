---
layout: page
title: Wellington, Hataitai, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Hataitai
city: Wellington
permalink: /country/new-zealand/wellington/hataitai/wellington/
---
[↑ Go to Hataitai](/country/new-zealand/wellington/hataitai/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Hataitai" | where: "city", "Wellington" %}
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
