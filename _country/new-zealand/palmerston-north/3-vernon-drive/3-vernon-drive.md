---
layout: page
title: 3 Vernon Drive, 3 Vernon Drive, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: 3 Vernon Drive
city: 3 Vernon Drive
permalink: /country/new-zealand/palmerston-north/3-vernon-drive/3-vernon-drive/
---
[↑ Go to 3 Vernon Drive](/country/new-zealand/palmerston-north/3-vernon-drive/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "3 Vernon Drive" | where: "city", "3 Vernon Drive" %}
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
