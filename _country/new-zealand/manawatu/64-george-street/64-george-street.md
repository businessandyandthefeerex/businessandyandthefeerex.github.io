---
layout: page
title: 64 George Street, 64 George Street, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 64 George Street
city: 64 George Street
permalink: /country/new-zealand/manawatu/64-george-street/64-george-street/
---
[↑ Go to 64 George Street](/country/new-zealand/manawatu/64-george-street/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "64 George Street" | where: "city", "64 George Street" %}
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
