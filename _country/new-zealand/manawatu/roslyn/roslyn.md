---
layout: page
title: Roslyn, Roslyn, Manawatu, New Zealand
country: New Zealand
region: Manawatu
suburb: Roslyn
city: Roslyn
permalink: /country/new-zealand/manawatu/roslyn/roslyn/
---
[↑ Go to Roslyn](/country/new-zealand/manawatu/roslyn/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Manawatu" | where: "suburb", "Roslyn" | where: "city", "Roslyn" %}
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
