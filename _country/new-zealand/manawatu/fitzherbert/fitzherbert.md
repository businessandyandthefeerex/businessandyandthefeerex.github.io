---
layout: page
title: Fitzherbert, Fitzherbert, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Fitzherbert
city: Fitzherbert
permalink: /country/new-zealand/manawatu/fitzherbert/fitzherbert/
---
[↑ Go to Fitzherbert](/country/new-zealand/manawatu/fitzherbert/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Fitzherbert" | where: "city", "Fitzherbert" %}
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
