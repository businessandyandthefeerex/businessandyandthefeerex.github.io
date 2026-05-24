---
layout: page
title: Berhampore, Wellington, New Zealand
country: New Zealand
region: Wellington
suburb: Berhampore
permalink: /country/new-zealand/wellington/berhampore/
---
[↑ Go to Wellington](/country/new-zealand/wellington/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Wellington" | where: "suburb", "Berhampore" %}
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
