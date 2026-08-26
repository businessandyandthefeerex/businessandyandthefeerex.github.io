---
layout: page
title: Wallingford, Hawkes Bay, New Zealand
country: New Zealand
region: Hawkes Bay
suburb: Wallingford
permalink: /country/new-zealand/hawkes-bay/wallingford/
---
[↑ Go to Hawkes Bay](/country/new-zealand/hawkes-bay/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Hawkes Bay" | where: "suburb", "Wallingford" %}
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
