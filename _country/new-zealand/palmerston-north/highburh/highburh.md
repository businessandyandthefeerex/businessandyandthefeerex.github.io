---
layout: page
title: Highburh, Highburh, Palmerston North, New Zealand
country: New Zealand
region: Palmerston North
suburb: Highburh
city: Highburh
permalink: /country/new-zealand/palmerston-north/highburh/highburh/
---
[↑ Go to Highburh](/country/new-zealand/palmerston-north/highburh/)

{% assign posts = site.posts | where: "country", "New Zealand" | where: "region", "Palmerston North" | where: "suburb", "Highburh" | where: "city", "Highburh" %}
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
