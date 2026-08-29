---
layout: page
title: Māngere, Māngere, Auckland, New Zealand
country: New Zealand
region: Auckland
suburb: Māngere
city: Māngere
permalink: /country/new-zealand/auckland/māngere/māngere/
---
[↑ Go to Māngere](/country/new-zealand/auckland/māngere/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Auckland" | where: "suburb", "Māngere" | where: "city", "Māngere" %}
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
