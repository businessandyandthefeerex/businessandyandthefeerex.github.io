---
layout: page
title: Manawatu, Manawatu, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Manawatu
city: Manawatu
permalink: /country/new-zealand/manawatu/manawatu/manawatu/
---
[↑ Go to Manawatu](/country/new-zealand/manawatu/manawatu/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Manawatu" | where: "city", "Manawatu" %}
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
