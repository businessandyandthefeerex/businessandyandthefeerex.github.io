---
layout: page
title: 22 George Street, 22 George Street, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: 22 George Street
city: 22 George Street
permalink: /country/new-zealand/manawatu/22-george-street/22-george-street/
---
[↑ Go to 22 George Street](/country/new-zealand/manawatu/22-george-street/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "22 George Street" | where: "city", "22 George Street" %}
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
