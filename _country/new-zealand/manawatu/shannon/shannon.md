---
layout: page
title: Shannon, Shannon, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Shannon
city: Shannon
permalink: /country/new-zealand/manawatu/shannon/shannon/
---
[↑ Go to Shannon](/country/new-zealand/manawatu/shannon/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Shannon" | where: "city", "Shannon" %}
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
