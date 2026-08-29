---
layout: page
title: Dannevirke, Dannevirke, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Dannevirke
city: Dannevirke
permalink: /country/new-zealand/manawatu/dannevirke/dannevirke/
---
[↑ Go to Dannevirke](/country/new-zealand/manawatu/dannevirke/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Dannevirke" | where: "city", "Dannevirke" %}
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
