---
layout: page
title: Highburh, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: Highburh
permalink: /country/new-zealand/palmerston-north/highburh/
---
[↑ Go to Palmerston North](/country/new-zealand/palmerston-north/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "Highburh" %}
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
