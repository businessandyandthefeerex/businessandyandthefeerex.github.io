---
layout: page
title: Invercargill, Southland, New Zealand
country: New Zealand
region: Southland
suburb: Invercargill
permalink: /country/new-zealand/southland/invercargill/
---
[↑ Go to Southland](/country/new-zealand/southland/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Southland" | where: "suburb", "Invercargill" %}
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
