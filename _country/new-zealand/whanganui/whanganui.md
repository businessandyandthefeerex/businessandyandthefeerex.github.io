---
layout: page
title: Whanganui, Whanganui, New Zealand
country: New Zealand
region: Whanganui
suburb: Whanganui
permalink: /country/new-zealand/whanganui/whanganui/
---
[↑ Go to Whanganui](/country/new-zealand/whanganui/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Whanganui" | where: "suburb", "Whanganui" %}
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
