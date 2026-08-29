---
layout: page
title: Wellington, Karaka Bays, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Karaka Bays
city: Wellington
permalink: /country/new-zealand/wellington/karaka-bays/wellington/
---
[↑ Go to Karaka Bays](/country/new-zealand/wellington/karaka-bays/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Karaka Bays" | where: "city", "Wellington" %}
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
