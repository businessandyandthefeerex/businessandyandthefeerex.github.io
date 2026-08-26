---
layout: page
title: Manapouri, Fiordland, New Zealand
country: New Zealand
region: Fiordland
suburb: Manapouri
permalink: /country/new-zealand/fiordland/manapouri/
---
[↑ Go to Fiordland](/country/new-zealand/fiordland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Fiordland" | where: "suburb", "Manapouri" %}
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
