---
layout: page
title: Picton, Marlborough, New Zealand
country: New Zealand
region: Marlborough
suburb: Picton
permalink: /country/new-zealand/marlborough/picton/
---
[↑ Go to Marlborough](/country/new-zealand/marlborough/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Marlborough" | where: "suburb", "Picton" %}
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
